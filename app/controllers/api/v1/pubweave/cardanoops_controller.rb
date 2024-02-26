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
          address = current_user.wallet_address
          json = { address: address, articleId: article_id, transactionLimit: transaction_limit, totalAmount: total_amount }
          headers = { 'Content-Type' => 'application/json' }
          response = HTTParty.post(url, body: json.to_json, headers: headers)
          p response
          
          render json: response
        end

        private

        def cardanoops_params
          params.require(:article).permit(:article_id, :transaction_limit, :total_amount)
        end
      end
    end
  end
end
