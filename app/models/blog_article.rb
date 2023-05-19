class BlogArticle < Article
  default_scope { Article.where(article_type: 'blog_article') }
end
