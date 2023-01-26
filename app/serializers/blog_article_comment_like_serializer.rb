class BlogArticleCommentLikeSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :blog_article_comment_id

  belongs_to :user
  belongs_to :blog_article_comment
end
