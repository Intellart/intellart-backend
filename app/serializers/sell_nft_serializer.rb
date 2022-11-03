class SellNftSerializer < ActiveModel::Serializer
  #embed :ids, :include => true
  attributes :fingerprint, :tradeable, :price, :name, :description, :subject, :nft_collection, :category, :url,
             :asset_name, :policy_id, :cardano_address, :created_at, :updated_at, :status

  has_one :user, foreign_key: 'owner_id', key: :owner

  def category
    object.category_id ? Category.find(object.category_id).category_name : ''
  end


  def cardano_address
    object.cardano_address_id ? CardanoAddress.find(object.cardano_address_id).address : ''
  end
end
