class BlogArticleSerializer < ActiveModel::Serializer
  attributes :id, :title, :subtitle, :content, :user, :likes, :status, :description, :image, :star, :category

  belongs_to :user
  has_many :blog_article_comments
  has_many :tags

  def category
    object.category_id ? Category.find(object.category_id).category_name : ''
  end
end
