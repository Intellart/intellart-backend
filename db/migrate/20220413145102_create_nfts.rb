class CreateNfts < ActiveRecord::Migration[6.1]
  def change
    create_table(:nfts, primary_key: :fingerprint, id: false) do |t|
      t.string :fingerprint, primary_key: true
      t.boolean :tradeable
      t.string :name
      t.decimal :price
      t.text :description
      t.string :state
      t.integer :sold_count, default: 0
      t.string :url
      t.string :asset_name
      t.string :policy_id
      t.references :owner, foreign_key: { to_table: :users }
      t.references :cardano_address, foreign_key: true

      t.timestamps
    end

    add_index :nfts, :fingerprint, unique: true
  end
end
