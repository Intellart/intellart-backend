class CreateExchangeRates < ActiveRecord::Migration[6.1]
  def change
    create_table :exchange_rates do |t|
      t.bigint :unix_time
      t.string :coin_id
      t.decimal :usd
      t.decimal :cad
      t.decimal :eur
      t.decimal :gbp
      t.timestamps
    end
  end
end
