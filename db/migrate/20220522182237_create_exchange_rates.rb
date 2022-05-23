class CreateExchangeRates < ActiveRecord::Migration[6.1]
  def change
    create_table :exchange_rates do |t|
      t.bigint :unix_time
      t.string :coin_id
      t.string :currency
      t.float :value
      t.timestamps
    end
  end
end
