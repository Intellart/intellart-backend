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

  def perform(fingerprint, retry_count = 0)
    nft = Nft.find(fingerprint)
    p 'Trying mint confirmation job...'
    # query blockfrost for an asset
    asset = make_hex_asset(nft)
    mint_result = query_asset(asset)

    nft.mint_success! and return if mint_result

    nft.mint_failed!

    CheckMintSuccessJob.set(wait: 1.minutes).perform_later(fingerprint, retry_count + 1) if retry_count < 12
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
