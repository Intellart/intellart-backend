class CreateNftCollections < ActiveRecord::Migration[6.1]
  def change
    create_table :nft_collections do |t|
      t.text :collection_name

      t.timestamps
    end
  end
end
