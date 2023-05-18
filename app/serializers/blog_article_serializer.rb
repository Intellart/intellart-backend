class BlogArticleSerializer < ActiveModel::Serializer
  attributes :id, :title, :subtitle, :content, :user, :likes, :status, :description, :image, :category, :created_at, :updated_at, :versions, :first_version, :last_version

  belongs_to :user
  has_many :comments
  has_many :tags

  def category
    object.category_id ? Category.find(object.category_id).category_name : ''
  end

  def versions
    BlogArticle.find(object.id).versions
  end

  def first_version
    BlogArticle.find(object.id).versions.first
  end

  def last_version
    BlogArticle.find(object.id).versions.last
  end
end
