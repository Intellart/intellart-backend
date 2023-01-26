class BlogArticleLikeSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :blog_article_id

  belongs_to :user
  belongs_to :blog_article
end
