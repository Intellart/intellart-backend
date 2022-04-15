class CreateCardanoAddresses < ActiveRecord::Migration[6.1]
  def change
    create_table :cardano_addresses do |t|
      t.string :address
      t.boolean :dirty
      t.references :wallet, foreign_key: true

      t.timestamps
    end
  end
end
