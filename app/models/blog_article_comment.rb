class BlogArticleComment < ApplicationRecord
  belongs_to :blog_article
  has_one :blog, through: :blog_article
  belongs_to :user, foreign_key: :commenter_id
end
