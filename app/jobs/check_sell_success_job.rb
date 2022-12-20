class CheckSellSuccessJob < ApplicationJob
  require 'dotenv/load'

  queue_as :sale_confirmation

  BLOCKFROST_PREVIEW_API_KEY = ENV.fetch('BLOCKFROST_PREVIEW_API_KEY')
  BLOCKFROST_API_PREVIEW = ENV.fetch('BLOCKFROST_API_PREVIEW')

  def query_address_for_asset(address, asset)
    response = HTTParty.get(address_url(address), headers: make_headers)

    return false unless response.code == 200

    amounts = response.parsed_response['amount']
    asset_on_script = amounts.any? { |unit| unit['unit'] == asset }

    return true if asset_on_script

    false
  end

  def perform(address, asset_name, fingerprint, sell_retry_count)
    nft = Nft.find(fingerprint)
    # query address for a specific asset
    asset = make_hex_asset(nft)
    nft_on_script_result = query_address_for_asset(address, asset)

    if nft_on_script_result
      sell_retry_count = 0
      nft.sell_success! and return
    else
      sell_retry_count = sell_retry_count + 1
      CheckSellSuccessJob.set(wait: 1.minutes).perform_later(address, asset_name, fingerprint, sell_retry_count) if sell_retry_count < 12 && !nft.on_sale?
    end
  end

  private

  def str_to_hex(str)
    str.each_byte.map { |b| b.to_s(16) }.join
  end

  def make_hex_asset(nft)
    nft.policy_id + str_to_hex(nft.asset_name)
  end

  def address_url(address)
    "#{BLOCKFROST_API_PREVIEW}/addresses/#{address}"
  end

  def make_headers
    { project_id: BLOCKFROST_PREVIEW_API_KEY }
  end
end
