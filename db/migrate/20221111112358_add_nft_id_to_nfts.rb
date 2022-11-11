class AddNftIdToNfts < ActiveRecord::Migration[6.1]
  def change
    add_column :nfts, :nft_id, :integer
  end
end
