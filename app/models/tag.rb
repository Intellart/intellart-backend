class Tag < ApplicationRecord
  has_and_belongs_to_many :articles, join_table: 'articles_tags', foreign_key: 'tag_id'
end
