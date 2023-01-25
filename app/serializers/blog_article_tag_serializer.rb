class BlogArticleTagSerializer < ActiveModel::Serializer
  attributes :id, :blog_article_id, :tag_id, :tag_name, :category_id

  has_one :tag
  has_one :blog_article, foreign_key: :blog_article_id

  def tag_name
    object.tag_id ? Tag.find(object.tag_id).tag : ''
  end

  def category_id
    object.tag_id ? Tag.find(object.tag_id).category_id : :null
  end
end
