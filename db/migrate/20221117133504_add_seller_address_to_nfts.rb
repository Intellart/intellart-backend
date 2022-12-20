class AddSellerAddressToNfts < ActiveRecord::Migration[6.1]
  def change
    add_column :nfts, :seller_address, :string
  end
end
