class BlogArticle < ApplicationRecord
  belongs_to :user
  has_many :blog_article_comments, class_name: 'BlogArticleComment'
end
