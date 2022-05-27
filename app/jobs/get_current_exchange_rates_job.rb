class GetCurrentExchangeRatesJob < ApplicationJob
  queue_as :default
  sidekiq_options retry: false

  def perform(*args)
    # get latest/current ADA->USD exchange rate, but include the timestamp of last rate
    # update as well
    data = CoingeckoService.get(
      '/simple/price',
      query: {
        ids: 'cardano',
        vs_currencies: 'usd,cad,eur,gbp',
        include_market_cap: false,
        include_24hr_vol: false,
        include_24hr_change: false,
        include_last_updated_at: true
      }
    ).parsed_response['cardano']

    return if ExchangeRate.find_by_unix_time(data['last_updated_at'])

    ExchangeRate.create!(
      unix_time: data['last_updated_at'],
      coin_id: 'cardano',
      usd: data['usd'],
      cad: data['cad'],
      eur: data['eur'],
      gbp: data['gbp']
    )
  end
end
