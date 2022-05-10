class RemoveTotalAndUsedFromWallets < ActiveRecord::Migration[6.1]
  def change
    remove_column :wallets, :total
    remove_column :wallets, :used
  end
end
