class PreprintSerializer < ActiveModel::Serializer
  attributes :id, :title, :subtitle, :content, :status, :description, :image, :star, :category, :created_at, :updated_at,
             :versions, :first_version, :last_version, :actor

  has_many :preprint_users, class_name: 'PreprintUser', foreign_key: 'preprint_id'
  has_many :users, through: :preprint_users, foreign_key: 'preprint_id'
  has_many :preprint_comments
  # has_many :tags

  def category
    object.category_id ? Category.find(object.category_id).category_name : ''
  end

  def actor
    Preprint.find(object.id).versions.last.actor
  end

  def versions
    Preprint.find(object.id).versions
  end

  def first_version
    Preprint.find(object.id).versions.first
  end

  def last_version
    Preprint.find(object.id).versions.last
  end
end
