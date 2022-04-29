class CreateNftEndorsers < ActiveRecord::Migration[6.1]
  def change
    create_table :nft_endorsers do |t|
      t.references :user, null: false, foreign_key: true
      t.column :fingerprint, :string

      t.timestamps
    end
  end
end
