class BlogArticleSerializer < ActiveModel::Serializer
  attributes :id, :title, :subtitle, :content

  belongs_to :blog
  has_many :blog_article_comments
end
