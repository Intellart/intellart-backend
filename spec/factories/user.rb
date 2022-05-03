FactoryBot.define do
  factory :user do
    first_name { "First" }
    last_name { "Last" }
    email { "test@test.com" }
    password { "123456" }
    orcid_id { "1" }
  end
end
