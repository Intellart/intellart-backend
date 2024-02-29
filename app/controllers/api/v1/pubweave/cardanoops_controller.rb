module Api
  module V1
    module Pubweave
      class CardanoopsController < ApplicationController
        require 'HTTParty'
        # POST api/v1/cardano/build_tx
        def build_tx
          url = "#{ENV['CARDANOOPS_BASE_URL']}/pubweave_build_tx"
          article_id = cardanoops_params['article_id']
          total_amount = cardanoops_params['total_amount']
          transaction_limit = cardanoops_params['transaction_limit']
          price_cap = cardanoops_params['price_cap']
          address = current_user.wallet_address
          json = { address: address, articleId: article_id, transactionLimit: transaction_limit, totalAmount: total_amount, priceCap: price_cap }
          headers = { 'Content-Type' => 'application/json' }
          response = HTTParty.post(url, body: json.to_json, headers: headers)
          p response

          render json: response
        end

        # POST api/v1/cardano/submit_tx
        def submit_tx
          url = "#{ENV['CARDANOOPS_BASE_URL']}/submit_tx"
          tx = cardanoops_params['tx']
          witness = cardanoops_params['witness']
          article_id = cardanoops_params['article_id']

          json = { tx: tx, witness: witness }
          headers = { 'Content-Type' => 'application/json' }
          response = HTTParty.post(url, body: json.to_json, headers: headers)
          Article.find(article_id).update!(tx_id: response['tx_id']) if response.ok?

          render json: response
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
          params.require(:article).permit(:article_id, :transaction_limit, :total_amount, :price_cap, :tx, :witness)
        end
      end
    end
  end
end
