class NftSerializer < ActiveModel::Serializer
  #embed :ids, :include => true
  attributes :fingerprint, :tradeable, :price, :name, :description, :subject, :nft_collection, :category,
             :asset_name, :policy_id, :onchain_transaction, :cardano_address, :created_at, :updated_at

  has_many :tags
  has_many :likes
  has_many :endorsers

  has_one :user, foreign_key: 'owner_id', key: :owner
  has_one :onchain_transaction

  def category
    object.category_id ? Category.find(object.category_id).category_name : ''
  end

  def nft_collection
    object.nft_collection_id ? NftCollection.find(object.nft_collection_id).collection_name : ''
  end

  def cardano_address
    object.cardano_address_id ? CardanoAddress.find(object.cardano_address_id).address : ''
  end
end
