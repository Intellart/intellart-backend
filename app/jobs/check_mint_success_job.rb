class CheckMintSuccessJob < ApplicationJob
  require 'dotenv/load'

  queue_as :default
  sidekiq_options retry: true

  BLOCKFROST_PREVIEW_API_KEY = ENV.fetch('BLOCKFROST_PREVIEW_API_KEY')
  BLOCKFROST_API_PREVIEW = ENV.fetch('BLOCKFROST_API_PREVIEW')

  def query_asset
    response = HTTParty.get(asset_url(asset), headers: make_headers)

    return false unless response.code == 200

    true
  end

  def perform(nft)
    # query blockfrost for an asset
    asset = make_asset(nft)
    mint_result = query_asset(asset)

    nft.mint_success! and return if mint_result

    nft.mint_failed!
  end

  private

  def make_asset(nft)
    nft.policy_id + nft.asset_name
  end

  def asset_url(asset)
    "#{BLOCKFROST_API_PREVIEW}/assets/#{asset}"
  end

  def make_headers
    { project_id: BLOCKFROST_PREVIEW_API_KEY }
  end
end
