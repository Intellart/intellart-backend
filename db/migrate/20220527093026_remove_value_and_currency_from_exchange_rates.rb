class RemoveValueAndCurrencyFromExchangeRates < ActiveRecord::Migration[6.1]
  def change
    remove_column :exchange_rates, :value, :float
    remove_column :exchange_rates, :currency, :string
  end
end
