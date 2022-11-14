class AddWitnessAndTxIdToNft < ActiveRecord::Migration[6.1]
  def change
    add_column :nfts, :tx_id, :string
    add_column :nfts, :witness, :string
  end
end
