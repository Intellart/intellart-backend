class BlogArticleTagSerializer < ActiveModel::Serializer
  attributes :id, :blog_article_id, :tag_name

  has_one :tag
  has_one :blog_article, foreign_key: :blog_article_id

  def tag_name
    object.tag_id ? Tag.find(object.tag_id).tag : ''
  end
end
