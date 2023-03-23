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

# Math tags
tag1 = Tag.create!(tag: 'Linear Algebra', category_id: cat1.id)
tag2 = Tag.create!(tag: 'Calculus', category_id: cat1.id)
tag3 = Tag.create!(tag: 'Differential Equations', category_id: cat1.id)
tag4 = Tag.create!(tag: 'Algebra', category_id: cat1.id)
tag5 = Tag.create!(tag: 'Geometry', category_id: cat1.id)
tag6 = Tag.create!(tag: 'Number Theory', category_id: cat1.id)

# Physics tags
tag7 = Tag.create!(tag: 'Mechanics', category_id: cat2.id)
tag8 = Tag.create!(tag: 'Thermodynamics', category_id: cat2.id)
tag9 = Tag.create!(tag: 'Electromagnetism', category_id: cat2.id)
tag10 = Tag.create!(tag: 'Quantum Mechanics', category_id: cat2.id)
tag11 = Tag.create!(tag: 'Relativity', category_id: cat2.id)
tag12 = Tag.create!(tag: 'Astrophysics', category_id: cat2.id)

# Chemistry tags
tag13 = Tag.create!(tag: 'Organic Chemistry', category_id: cat3.id)
tag14 = Tag.create!(tag: 'Inorganic Chemistry' , category_id: cat3.id)
tag15 = Tag.create!(tag: 'Physical Chemistry' , category_id: cat3.id)
tag16 = Tag.create!(tag: 'Analytical Chemistry' , category_id: cat3.id)
tag17 = Tag.create!(tag: 'Biochemistry')


# Biology tags
tag18 = Tag.create!(tag: 'Cell Biology' , category_id: cat4.id)
tag19 = Tag.create!(tag: 'Molecular Biology' , category_id: cat4.id)
tag20 = Tag.create!(tag: 'Genetics' , category_id: cat4.id)
tag21 = Tag.create!(tag: 'Ecology' , category_id: cat4.id)
tag22 = Tag.create!(tag: 'Evolution' , category_id: cat4.id)
tag23 = Tag.create!(tag: 'Zoology' , category_id: cat4.id)

# Computer Science tags
tag24 = Tag.create!(tag: 'Algorithms' , category_id: cat5.id)
tag25 = Tag.create!(tag: 'Data Structures' , category_id: cat5.id)
tag26 = Tag.create!(tag: 'Programming Languages' , category_id: cat5.id)
tag27 = Tag.create!(tag: 'Operating Systems' , category_id: cat5.id)
tag28 = Tag.create!(tag: 'Computer Architecture' , category_id: cat5.id)
tag29 = Tag.create!(tag: 'Artificial Intelligence' , category_id: cat5.id)

# Engineering tags
tag30 = Tag.create!(tag: 'Mechanical Engineering' , category_id: cat6.id)
tag31 = Tag.create!(tag: 'Electrical Engineering' , category_id: cat6.id)
tag32 = Tag.create!(tag: 'Civil Engineering' , category_id: cat6.id)

# Law tags
tag33 = Tag.create!(tag: 'Criminal Law' , category_id: cat13.id)
tag34 = Tag.create!(tag: 'Civil Law' , category_id: cat13.id)
tag35 = Tag.create!(tag: 'Constitutional Law' , category_id: cat13.id)
tag36 = Tag.create!(tag: 'Administrative Law' , category_id: cat13.id)
tag37 = Tag.create!(tag: 'International Law' , category_id: cat13.id)
tag38 = Tag.create!(tag: 'Tax Law' , category_id: cat13.id)






rating1 = Rating.create!(user_id: 1, rated_user_id: 2, rating: 5)
rating2 = Rating.create!(user_id: 2, rated_user_id: 1, rating: 1)

# article1 = BlogArticle.create!(
#   user_id: user1.id, 
#   title: "Vector Spaces",
#   subtitle: "Vector Spaces and Subspaces",
#   content: {"blocks": "", "time": 0}, 
#   description: "Vector spaces are a very important topic in mathematics.",
#   status: 'draft', 
#   star: false, 
#   category_id: 1)
# article2 = BlogArticle.create!(
#   user_id: user1.id, 
#   title: "Animal Behavior",
#   subtitle: "Animal Behavior and Evolution",
#   content: {"blocks": "", "time": 1}, 
#   description: "Animal behavior is a very important topic in biology.",
#   status: 'draft', 
#   star: false, 
#   category_id: 1)

# art_tag1 = BlogArticleTag.create!(tag_id: 1, blog_article_id: 1)
# art_tag2 = BlogArticleTag.create!(tag_id: 2, blog_article_id: 1)
# art_tag3 = BlogArticleTag.create!(tag_id: 1, blog_article_id: 2)

# comment1 = BlogArticleComment.create!(
#   blog_article_id: article1.id, 
#   commenter_id: user3.id, 
#   comment: "What is a vector space?"
# )

# comment2 = BlogArticleComment.create!(
#   blog_article_id: article1.id, 
#   commenter_id: user4.id, 
#   comment: "A vector space is a set of vectors that satisfy certain properties.",
#   reply_to_id: 1
# )


# comment3 = BlogArticleComment.create!(
#   blog_article_id: article2.id, 
#   commenter_id: user3.id, 
#   comment: "What is animal behavior?",
#   reply_to_id: 2
# )

Admin.create!(email: 'a@a.com', password: '123456')