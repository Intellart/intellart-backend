class BlogArticle < ApplicationRecord
  belongs_to :blog
  has_one :user, through: :blog, source: :user_id
  has_many :blog_article_comments, class_name: 'BlogArticleComment'
end
