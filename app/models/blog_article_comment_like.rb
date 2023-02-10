class BlogArticleCommentLike < ApplicationRecord
  belongs_to :user, dependent: :destroy
  belongs_to :blog_article_comment, foreign_key: :blog_article_comment_id

  validates :blog_article_comment_id, uniqueness: { scope: :user_id, message: 'This user has already liked this comment.' }

  def active_model_serializer
    BlogArticleCommentLikeSerializer
  end
end