module Api
  module V1
    module Pubweave
      class CardanoopsController < ApplicationController
        require 'HTTParty'
        # POST api/v1/cardano/build_tx
        def build_tx
          url = "#{ENV['CARDANOOPS_BASE_URL']}/pubweave/fill/build_tx"
          article_id = cardanoops_params['article_id']
          total_amount = cardanoops_params['total_amount']
          # TODO: transaction_limit = cardanoops_params['transaction_limit']
          # TODO: price_cap = cardanoops_params['price_cap']
          address = current_user.wallet_address
          json = { change_address: address, senders: [address], recipients: [[ENV['TREASURY_ADDRESS'], total_amount.to_s]] }
          headers = { 'Content-Type' => 'application/json' }
          response = HTTParty.post(url, body: json.to_json, headers: headers)
          Article.find(article_id).update!(tx_amount_in_treasury: total_amount) if response.ok?

          if response.ok?
            render json: response, status: :ok
          else
            render json: response, status: :unprocessable_entity
          end
        end

        # POST api/v1/cardano/submit_tx
        def submit_tx
          url = "#{ENV['CARDANOOPS_BASE_URL']}/pubweave/fill/submit_tx"
          tx = cardanoops_params['tx']
          witness = cardanoops_params['witness']
          article_id = cardanoops_params['article_id']

          json = { tx: tx, witness: witness }
          headers = { 'Content-Type' => 'application/json' }
          response = HTTParty.post(url, body: json.to_json, headers: headers)
          Article.find(article_id).update!(tx_id: response['tx_id']) if response.ok?

          if response.ok?
            render json: response, status: :ok
          else
            render json: response, status: :unprocessable_entity
          end
        end

        # POST api/v1/cardano/treasury_spend_build_tx
        def treasury_spend_build_tx
          url = "#{ENV['CARDANOOPS_BASE_URL']}/pubweave/spend/build_tx"
          article_id = cardanoops_params['article_id']
          article = Article.find(article_id)
          utxo_index = 0
          utxo_id = article.tx_id
          author_address = article.author.wallet_address
          article_review = article.reviews.first
          reviewers_addresses = []
          article_review.user_reviews.each do |user_review|
            reviewers_addresses << user_review.user.wallet_address if user_review.status == 'accepted'
          end

          json = { utxoID: utxo_id, utxoIndex: utxo_index, senders: [author_address], change_address: author_address, address: reviewers_addresses.first }
          headers = { 'Content-Type' => 'application/json' }
          response = HTTParty.post(url, body: json.to_json, headers: headers)

          if response.ok?
            render json: response, status: :ok
          else
            render json: response, status: :unprocessable_entity
          end
        end

        # POST api/v1/cardano/treasury_spend_submit_tx
        def treasury_spend_submit_tx
          url = "#{ENV['CARDANOOPS_BASE_URL']}/pubweave/spend/submit_tx"
          tx = cardanoops_params['tx']
          witness = cardanoops_params['witness']
          witness_set = cardanoops_params['witness_set']

          json = { tx: tx, witness: witness, witness_set: witness_set }
          headers = { 'Content-Type' => 'application/json' }
          response = HTTParty.post(url, body: json.to_json, headers: headers)

          if response.ok?
            render json: response, status: :ok
          else
            render json: response, status: :unprocessable_entity
          end
        end

        # GET api/v1/cardano/treasury_status
        def treasury_status
          article_id = params['article_id']
          url = "#{ENV['CARDANOOPS_BASE_URL']}/treasury/#{article_id}/"

          response = HTTParty.get(url)

          render json: response
        end

        private

        def cardanoops_params
          params.require(:article).permit(:article_id, :transaction_limit, :total_amount, :price_cap, :tx, :witness, :witness_set)
        end
      end
    end
  end
end
