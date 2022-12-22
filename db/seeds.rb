# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

field1 = StudyField.create(field_name: 'Physics')
field2 = StudyField.create(field_name: 'Chemistry')

user1 = User.create!(
  email: 'test@test.com',
  first_name: 'First name',
  last_name: 'Last name',
  password: '123456',
  orcid_id: '0000-0000-0000-0001',
  study_field_id: 1
)
user2 = User.create!(
  email: 'test2@test.com',
  first_name: 'Name',
  last_name: 'Lastname',
  password: '123456',
  orcid_id: '0000-0000-0000-0002',
  study_field_id: 2
)
user3 = User.create!(
  email: 'test3@test.com',
  first_name: 'Name',
  last_name: 'Lastname',
  password: '123456',
)
user4 = User.create!(
  email: 'test4@test.com',
  first_name: 'Fourth',
  last_name: 'User',
  password: '123456',
)

tag1 = Tag.create!(tag: 'test-tag')
tag2 = Tag.create!(tag: 'test-tag-2')


cat1 = Category.create!(category_name: 'test-category')


rating1 = Rating.create!(user_id: 1, rated_user_id: 2, rating: 5)
rating2 = Rating.create!(user_id: 2, rated_user_id: 1, rating: 1)

article1 = BlogArticle.create!(user_id: user3.id, title: "Title", subtitle: "Subtitle", content: "Content")
article2 = BlogArticle.create!(user_id: user4.id, title: "Title 2", subtitle: "Subtitle 2", content: "Content")

comment1 = BlogArticleComment.create!(blog_article_id: article1.id, commenter_id: user3.id, comment: "Comment")
comment2 = BlogArticleComment.create!(blog_article_id: article1.id, commenter_id: user4.id, comment: "Comment 2", reply_to_id: 1)
comment3 = BlogArticleComment.create!(blog_article_id: article2.id, commenter_id: user3.id, comment: "Comment 3", reply_to_id: 2)