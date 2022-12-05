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
  study_field_id: 1,
  domain: 'Intellart'
)
user2 = User.create!(
  email: 'test2@test.com',
  first_name: 'Name',
  last_name: 'Lastname',
  password: '123456',
  orcid_id: '0000-0000-0000-0002',
  study_field_id: 2,
  domain: 'Intellart'
)
user3 = User.create!(
  email: 'test2@test.com',
  first_name: 'Name',
  last_name: 'Lastname',
  password: '123456',
  domain: 'Pubweave'
)

admin = Admin.create!(
  email: 'a@a.com',
  password: '123456'
)


tag1 = Tag.create!(tag: 'test-tag')
tag2 = Tag.create!(tag: 'test-tag-2')


cat1 = Category.create!(category_name: 'test-category')


rating1 = Rating.create!(user_id: 1, rated_user_id: 2, rating: 5)
rating2 = Rating.create!(user_id: 2, rated_user_id: 1, rating: 1)
