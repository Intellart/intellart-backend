class AddUniqueIndexes < ActiveRecord::Migration[6.1]
  def change
    add_index :ratings, [:user_id, :rated_user_id], unique: true
    add_index :nft_likes, [:user_id, :fingerprint], unique: true
    add_index :nft_tags, [:tag_id, :fingerprint], unique: true
    add_index :nft_endorsers, [:user_id, :fingerprint], unique: true
  end
end
