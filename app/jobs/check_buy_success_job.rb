class CheckBuySuccessJob < ApplicationJob
  require 'dotenv/load'

  queue_as :buy_confirmation

  BLOCKFROST_PREVIEW_API_KEY = ENV.fetch('BLOCKFROST_PREVIEW_API_KEY')
  BLOCKFROST_API_PREVIEW = ENV.fetch('BLOCKFROST_API_PREVIEW')

  # TODO: implement logic for buy confirmation
  def query_address_for_asset(address, asset)
    response = HTTParty.get(address_url(address), headers: make_headers)

    return false unless response.code == 200

    amounts = response.parsed_response['amount']
    asset_on_script = amounts.any? { |unit| unit['unit'] == asset }

    # we want the result to be false, means the asset has been bought/redeemed from script address
    return true unless asset_on_script

    false
  end

  def perform(address, asset_name, fingerprint, buy_retry_count)
    nft = Nft.find(fingerprint)
    # query address for a specific asset
    asset = make_hex_asset(nft)
    nft_not_on_script_result = query_address_for_asset(address, asset)

    if nft_not_on_script_result
      buy_retry_count = 0
      nft.buy_success!
      nft.update(sold_count: @nft.sold_count + 1, owner_id: @current_user.id) and return
    else
      buy_retry_count = buy_retry_count + 1
      CheckBuySuccessJob.set(wait: 1.minutes).perform_later(address, asset_name, fingerprint, buy_retry_count) if buy_retry_count < 12 && nft.on_sale?
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
