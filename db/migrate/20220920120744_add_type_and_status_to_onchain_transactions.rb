class AddTypeAndStatusToOnchainTransactions < ActiveRecord::Migration[6.1]
  def change
    add_column :onchain_transactions, :type, :string
    add_column :onchain_transactions, :status, :string
  end
end
