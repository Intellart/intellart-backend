class AddCurrenciesToExchangeRates < ActiveRecord::Migration[6.1]
  def change
    add_column :exchange_rates, :usd, :float
    add_column :exchange_rates, :cad, :float
    add_column :exchange_rates, :eur, :float
    add_column :exchange_rates, :gbp, :float
  end
end
