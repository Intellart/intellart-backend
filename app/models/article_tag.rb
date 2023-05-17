class ArticleTag < ApplicationRecord
  belongs_to :tag
  belongs_to :article, foreign_key: :article_id

  validates :article_id, uniqueness: { scope: :tag_id, message: 'Tag already exists on this article.' }
end
