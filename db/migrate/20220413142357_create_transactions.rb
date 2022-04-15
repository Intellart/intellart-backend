class CreateTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :transactions do |t|
      t.datetime :timestamp
      t.string :seller_address
      t.string :buyer_address
      t.decimal :price
      t.text :onchain_transaction_id

      t.timestamps
    end
  end
end
