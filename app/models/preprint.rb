class Preprint < BlogArticle
  default_scope { Article.where(article_type: 'preprint') }
end
