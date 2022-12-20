class CheckMintSuccessJob < ApplicationJob
  require 'dotenv/load'

  queue_as :mint_confirmation

  BLOCKFROST_PREVIEW_API_KEY = ENV.fetch('BLOCKFROST_PREVIEW_API_KEY')
  BLOCKFROST_API_PREVIEW = ENV.fetch('BLOCKFROST_API_PREVIEW')

  def query_asset(asset)
    response = HTTParty.get(asset_url(asset), headers: make_headers)

    return false unless response.code == 200

    true
  end

  def perform(fingerprint, mint_retry_count)
    nft = Nft.find(fingerprint)

    # query blockfrost for an asset
    asset = make_hex_asset(nft)
    mint_result = query_asset(asset)

    if mint_result
      mint_retry_count = 0
      nft.mint_success! and return
    else
      nft.mint_failed!
      mint_retry_count = mint_retry_count + 1
      CheckMintSuccessJob.set(wait: 1.minutes).perform_later(fingerprint, mint_retry_count) if mint_retry_count < 12 && nft.mint_failed?
    end
  end

  private

  def str_to_hex(str)
    str.each_byte.map { |b| b.to_s(16) }.join
  end

  def make_hex_asset(nft)
    nft.policy_id + str_to_hex(nft.asset_name)
  end

  def asset_url(asset)
    "#{BLOCKFROST_API_PREVIEW}/assets/#{asset}"
  end

  def make_headers
    { project_id: BLOCKFROST_PREVIEW_API_KEY }
  end
end
