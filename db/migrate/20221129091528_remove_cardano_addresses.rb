class RemoveCardanoAddresses < ActiveRecord::Migration[6.1]
  def change
    remove_index :nfts, name: :index_nfts_on_cardano_address_id
    remove_column :nfts, :cardano_address_id

    drop_table :cardano_addresses
  end
end
