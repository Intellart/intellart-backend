class BlogArticleComment < ApplicationRecord
  belongs_to :blog_article
  belongs_to :commenter, class_name: 'User', foreign_key: :commenter_id
  belongs_to :reply_to, class_name: 'BlogArticleComment', foreign_key: :reply_to_id, optional: true, dependent: :destroy
  has_many :replies, class_name: 'BlogArticleComment', foreign_key: :reply_to_id, dependent: :destroy
  has_many :likes, class_name: 'BlogArticleCommentLike', foreign_key: :blog_article_comment_id, dependent: :destroy
  has_many :dislikes, class_name: 'BlogArticleCommentDislike', foreign_key: :blog_article_comment_id, dependent: :destroy

  def active_model_serializer
    BlogArticleCommentSerializer
  end
end
