module Api
  module V1
    module Intellart
      class PythonController < ApplicationController
        after_action :refresh_jwt

        def generate_nft
          b64_string = `python3 lib/assets/python/generative_nft.py #{nft_params}`
          render json: b64_string, status: :ok
        end

        def nft_params; end
      end
    end
  end
end
