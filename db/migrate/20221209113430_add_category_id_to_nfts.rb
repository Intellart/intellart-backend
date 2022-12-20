class AddCategoryIdToNfts < ActiveRecord::Migration[7.0]
  def change
    add_reference :nfts, :category, null: false, foreign_key: true
  end
end
