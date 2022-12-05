class BlogSerializer < ActiveModel::Serializer
  attributes :id

  has_one :user
  has_many :blog_articles
  has_many :blog_article_comments
end
