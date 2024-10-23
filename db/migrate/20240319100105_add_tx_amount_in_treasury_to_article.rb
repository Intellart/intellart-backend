class AddTxAmountInTreasuryToArticle < ActiveRecord::Migration[7.0]
  def change
    add_column :articles, :tx_amount_in_treasury, :integer
  end
end
