class CheckMintSuccessJob < ApplicationJob
  require 'dotenv/load'

  queue_as :default
  sidekiq_options retry: true

  BLOCKFROST_PREPROD_API_KEY = ENV.fetch('BLOCKFROST_PREPROD_API_KEY')
  BLOCKFROST_API_PREPROD = ENV.fetch('BLOCKFROST_API_PREPROD')

  def query_asset
    response = HTTParty.get(asset_url(asset), headers: make_headers)

    return false unless response.code == 200

    true
  end

  def perform(asset)
    # query blockfrost for an asset
    mint_result = query_asset(asset)

    @nft.mint_success! and return if mint_result

    @nft.mint_failed!
  end

  private

  def find_nft(asset)
    # TODO: construct fingerprint from asset
    fingerprint = construct_fingerprint(asset)

    @nft = Nft.find(fingerprint)
  end

  def asset_url(asset)
    "#{BLOCKFROST_API_PREPROD}/assets/#{asset}"
  end

  def make_headers
    { project_id: BLOCKFROST_PREPROD_API_KEY }
  end
end
