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
  first_name: 'John',
  last_name: 'Doe',
  password: '123456',
  orcid_id: '0123-4567-8901-2345',
  study_field_id: 1
)
user2 = User.create!(
  email: 'peter@test.com',
  first_name: 'Peter',
  last_name: 'Parker',
  password: '123456',
  orcid_id: '9876-5432-1098-7654',
  study_field_id: 2
)
user3 = User.create!(
  email: 'joanne@test.com',
  first_name: 'Joanne',
  last_name: 'Archer',
  password: '123456',
)
user4 = User.create!(
  email: 'mark@test.com',
  first_name: 'Mark',
  last_name: 'Smith',
  password: '123456',
)


# Math tags
tag1 = Tag.create!(tag: 'Linear Algebra')
tag2 = Tag.create!(tag: 'Calculus')
tag3 = Tag.create!(tag: 'Differential Equations')
tag4 = Tag.create!(tag: 'Algebra')
tag5 = Tag.create!(tag: 'Geometry')
tag6 = Tag.create!(tag: 'Number Theory')

# Physics tags
tag7 = Tag.create!(tag: 'Mechanics')
tag8 = Tag.create!(tag: 'Thermodynamics')
tag9 = Tag.create!(tag: 'Electromagnetism')
tag10 = Tag.create!(tag: 'Quantum Mechanics')
tag11 = Tag.create!(tag: 'Relativity')
tag12 = Tag.create!(tag: 'Astrophysics')

# Chemistry tags
tag13 = Tag.create!(tag: 'Organic Chemistry')
tag14 = Tag.create!(tag: 'Inorganic Chemistry')
tag15 = Tag.create!(tag: 'Physical Chemistry')
tag16 = Tag.create!(tag: 'Analytical Chemistry')
tag17 = Tag.create!(tag: 'Biochemistry')


# Biology tags
tag18 = Tag.create!(tag: 'Cell Biology')
tag19 = Tag.create!(tag: 'Molecular Biology')
tag20 = Tag.create!(tag: 'Genetics')
tag21 = Tag.create!(tag: 'Ecology')
tag22 = Tag.create!(tag: 'Evolution')
tag23 = Tag.create!(tag: 'Zoology')

# Computer Science tags
tag24 = Tag.create!(tag: 'Algorithms')
tag25 = Tag.create!(tag: 'Data Structures')
tag26 = Tag.create!(tag: 'Programming Languages')
tag27 = Tag.create!(tag: 'Operating Systems')
tag28 = Tag.create!(tag: 'Computer Architecture')
tag29 = Tag.create!(tag: 'Artificial Intelligence')

# Engineering tags
tag30 = Tag.create!(tag: 'Mechanical Engineering')
tag31 = Tag.create!(tag: 'Electrical Engineering')
tag32 = Tag.create!(tag: 'Civil Engineering')

# Law tags
tag33 = Tag.create!(tag: 'Criminal Law')
tag34 = Tag.create!(tag: 'Civil Law')
tag35 = Tag.create!(tag: 'Constitutional Law')
tag36 = Tag.create!(tag: 'Administrative Law')
tag37 = Tag.create!(tag: 'International Law')
tag38 = Tag.create!(tag: 'Tax Law')


cat1 = Category.create!(category_name: 'Mathematics')
cat2 = Category.create!(category_name: 'Physics')
cat3 = Category.create!(category_name: 'Chemistry')
cat4 = Category.create!(category_name: 'Biology')
cat5 = Category.create!(category_name: 'Computer Science')
cat6 = Category.create!(category_name: 'Engineering')
cat7 = Category.create!(category_name: 'Economics')
cat8 = Category.create!(category_name: 'Medicine')
cat9 = Category.create!(category_name: 'Psychology')
cat10 = Category.create!(category_name: 'Philosophy')
cat11 = Category.create!(category_name: 'History')
cat12 = Category.create!(category_name: 'Geography')
cat13 = Category.create!(category_name: 'Law')
cat14 = Category.create!(category_name: 'Other')



rating1 = Rating.create!(user_id: 1, rated_user_id: 2, rating: 5)
rating2 = Rating.create!(user_id: 2, rated_user_id: 1, rating: 1)

article1 = BlogArticle.create!(
  user_id: user1.id, 
  title: "Vector Spaces",
  subtitle: "Vector Spaces and Subspaces",
  content: {"blocks": "", "time": 0}, 
  description: "Vector spaces are a very important topic in mathematics.",
  status: 'draft', 
  star: false, 
  category_id: 1)
article2 = BlogArticle.create!(
  user_id: user1.id, 
  title: "Animal Behavior",
  subtitle: "Animal Behavior and Evolution",
  content: {"blocks": "", "time": 1}, 
  description: "Animal behavior is a very important topic in biology.",
  status: 'draft', 
  star: false, 
  category_id: 1)

art_tag1 = BlogArticleTag.create!(tag_id: 1, blog_article_id: 1)
art_tag2 = BlogArticleTag.create!(tag_id: 2, blog_article_id: 1)
art_tag3 = BlogArticleTag.create!(tag_id: 1, blog_article_id: 2)

comment1 = BlogArticleComment.create!(
  blog_article_id: article1.id, 
  commenter_id: user3.id, 
  comment: "What is a vector space?"
)

comment2 = BlogArticleComment.create!(
  blog_article_id: article1.id, 
  commenter_id: user4.id, 
  comment: "A vector space is a set of vectors that satisfy certain properties.",
  reply_to_id: 1
)


comment3 = BlogArticleComment.create!(
  blog_article_id: article2.id, 
  commenter_id: user3.id, 
  comment: "What is animal behavior?",
  reply_to_id: 2
)