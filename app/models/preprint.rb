class Preprint < Article
  default_scope { Article.where(article_type: 'preprint') }
end
