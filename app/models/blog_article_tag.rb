class BlogArticleTag < ApplicationRecord
  belongs_to :tag
  belongs_to :blog_article, foreign_key: :blog_article_id, dependent: :destroy

  validates :blog_article_id, uniqueness: { scope: :tag_id, message: 'Tag already exists on this article.' }

  def active_model_serializer
    BlogArticleTagSerializer
  end
end
