class ScientificArticle < Article
  default_scope { Article.where(article_type: 'scientific_article') }
end
