class CreateWallets < ActiveRecord::Migration[6.1]
  def change
    create_table :wallets do |t|
      t.integer :total
      t.integer :used
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
