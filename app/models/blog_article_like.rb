class BlogArticleLike < ApplicationRecord
  belongs_to :user
  belongs_to :blog_article

  validates :blog_article_id, uniqueness: { scope: :user_id, message: 'This user has already liked this article.' }

  def active_model_serializer
    BlogArticleLikeSerializer
  end
end
