class Api::V1::BlockfrostController < ApplicationController
  require 'dotenv/load'

  BLOCKFROST_TESTNET_API_KEY = ENV.fetch('BLOCKFROST_TESTNET_API_KEY')
  BLOCKFROST_PREPROD_API_KEY = ENV.fetch('BLOCKFROST_PREPROD_API_KEY')
  BLOCKFROST_API_PREPROD = ENV.fetch('BLOCKFROST_API_PREPROD')

  # GET /api/v1/blockfrost/query_address/:address?:asset
  def query_address_for_asset
    response = HTTParty.get(address_url, headers: make_headers)

    return unless response.code == 200

    amounts = response.parsed_response['amount']
    asset_on_script = amounts.any? { |asset| asset['unit'] == address_params[:asset] }

    return if asset_on_script

    render json: response, status: :ok
  end

  # GET /api/v1/blockfrost/query_asset/:asset
  def query_asset
    response = HTTParty.get(asset_url, headers: make_headers)

    return unless response.code == 200

    render json: response.parsed_response, status: :ok
  end

  private

  def address_url
    "#{BLOCKFROST_API_PREPROD}/addresses/#{address_params[:address]}"
  end

  def asset_url
    "#{BLOCKFROST_API_PREPROD}/assets/#{asset_params[:asset]}"
  end

  def make_headers
    { project_id: BLOCKFROST_PREPROD_API_KEY }
  end

  def asset_params
    # TODO: asset needs to be in format <policy_id+asset_name>
    params.permit(:asset)
  end

  def address_params
    # TODO: asset needs to be in format <policy_id+asset_name>
    params.permit(:address, :asset)
  end
end
