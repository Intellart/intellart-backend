class Api::V1::PythonController < ApplicationController
  after_action :refresh_jwt

  def generate_nft
    b64_string = `python3 lib/assets/python/generative_nft.py #{nft_params}`
    render json: b64_string, status: :ok
  end

  def nft_params

  end
end
