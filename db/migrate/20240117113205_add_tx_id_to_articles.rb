class AddTxIdToArticles < ActiveRecord::Migration[7.0]
  def change
    add_column :articles, :tx_id, :string
  end
end
