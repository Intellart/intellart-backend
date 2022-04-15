class CreateNftLikes < ActiveRecord::Migration[6.1]
  def change
    create_table :nft_likes do |t|
      t.references :user, null: false, foreign_key: true
      t.column :fingerprint, :string

      t.timestamps
    end

    add_foreign_key :nft_likes, :nfts, column: :fingerprint, primary_key: :fingerprint
  end
end
