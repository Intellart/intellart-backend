class CheckSellSuccessJob < ApplicationJob
  require 'dotenv/load'

  queue_as :default
  sidekiq_options retry: true

  BLOCKFROST_PREVIEW_API_KEY = ENV.fetch('BLOCKFROST_PREVIEW_API_KEY')
  BLOCKFROST_API_PREVIEW = ENV.fetch('BLOCKFROST_API_PREVIEW')

  def query_address_for_asset(address, asset)
    response = HTTParty.get(address_url(address), headers: make_headers)

    return false unless response.code == 200

    amounts = response.parsed_response['amount']
    asset_on_script = amounts.any? { |unit| unit['unit'] == asset }

    return false if asset_on_script

    true
  end

  def perform(address, asset)
    # query address for a specific asset
    sell_result = query_address_for_asset(address, asset)

    return unless sell_result

    @nft.sell_success!
  end

  private

  def address_url(address)
    "#{BLOCKFROST_API_PREVIEW}/addresses/#{address}"
  end

  def make_headers
    { project_id: BLOCKFROST_PREVIEW_API_KEY }
  end
end
