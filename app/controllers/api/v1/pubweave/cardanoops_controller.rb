module Api
  module V1
    module Pubweave
      class CardanoopsController < ApplicationController
        require 'HTTParty'
        before_action :set_article, only: [:treasury_fill_build_tx, :treasury_fill_submit_tx, :treasury_spend_build_tx, :treasury_spend_submit_tx]

        # POST api/v1/cardanoops/treasury_fill_build_tx
        def treasury_fill_build_tx
          # TODO: transaction_limit = cardanoops_params['transaction_limit']
          # TODO: price_cap = cardanoops_params['price_cap']
          url = "#{ENV['CARDANOOPS_BASE_URL']}/pubweave/fill/build_tx"
          total_amount = cardanoops_params['total_amount']
          address = current_user.wallet_address
          json = { change_address: address, senders: [address], recipients: [[ENV['TREASURY_ADDRESS'], total_amount.to_s]] }

          response = send_request(url, json, headers)

          if response.ok?
            @article.update!(tx_amount_in_treasury: total_amount)
            render json: response, status: :ok
          else
            render json: response, status: :unprocessable_entity
          end
        end

        # POST api/v1/cardanoops/treasury_fill_submit_tx
        def treasury_fill_submit_tx
          url = "#{ENV['CARDANOOPS_BASE_URL']}/pubweave/fill/submit_tx"
          tx = cardanoops_params['tx']
          witness = cardanoops_params['witness']
          json = { tx: tx, witness: witness }

          response = send_request(url, json, headers)

          if response.ok?
            @article.update!(tx_id: response['tx_id'])
            render json: response, status: :ok
          else
            render json: response, status: :unprocessable_entity
          end
        end

        # POST api/v1/cardanoops/treasury_spend_build_tx
        def treasury_spend_build_tx
          url = "#{ENV['CARDANOOPS_BASE_URL']}/pubweave/spend/build_tx"
          author_address = @article.author.wallet_address
          article_review = @article.reviews.first
          user_reviewes = article_review.user_reviews.where(status: 'accepted')

          reviewers_for_payout = []
          user_reviewes = user_reviewes.filter { |user_review| user_review.user.wallet_address.present? }
          user_reviewes.each do |user_review|
            reviewers_for_payout << [user_review.user.wallet_address, user_review.review.amount.to_i]
          end

          json = { utxoID: @article.tx_id, utxoIndex: 0, senders: [author_address], change_address: author_address, recipients: reviewers_for_payout }
          response = send_request(url, json, headers)

          if response.ok?
            user_reviewes.each(&:process!)
            render json: response, status: :ok
          else
            render json: response, status: :unprocessable_entity
          end
        end

        # POST api/v1/cardanoops/treasury_spend_submit_tx
        def treasury_spend_submit_tx
          url = "#{ENV['CARDANOOPS_BASE_URL']}/pubweave/spend/submit_tx"
          tx = cardanoops_params['tx']
          witness = cardanoops_params['witness']
          witness_set = cardanoops_params['witness_set']

          json = { tx: tx, witness: witness, witness_set: witness_set }
          response = send_request(url, json, headers)

          if response.ok?
            article_review = @article.reviews.first
            article_review.user_reviews.where(status: 'awaiting_payout').each(&:pay!)
            render json: response, status: :ok
          else
            render json: response, status: :unprocessable_entity
          end
        end

        private

        def send_request(url, body, headers)
          HTTParty.post(url, body: body.to_json, headers: headers)
        end

        def set_article
          @article = Article.find(cardanoops_params['article_id'])
        end

        def headers
          { 'Content-Type' => 'application/json' }
        end

        def cardanoops_params
          params.require(:article).permit(:article_id, :transaction_limit, :total_amount, :price_cap, :tx, :witness, :witness_set)
        end
      end
    end
  end
end
