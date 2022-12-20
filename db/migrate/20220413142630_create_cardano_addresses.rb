class CreateCardanoAddresses < ActiveRecord::Migration[6.1]
  def change
    create_table :cardano_addresses do |t|
      t.string :address
      t.boolean :dirty

      t.timestamps
    end
  end
end
