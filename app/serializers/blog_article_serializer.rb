class BlogArticleSerializer < ActiveModel::Serializer
  attributes :id, :title, :subtitle, :content, :user, :likes

  belongs_to :user
  has_many :blog_article_comments
end
