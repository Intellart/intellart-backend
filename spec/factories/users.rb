FactoryBot.define do
  factory :user do
    first_name { "First" }
    last_name { "Last" }
    email { "test@test.com" }
    password { "123456" }
    orcid_id { "0000-0000-0000-0001" }
    association :study_field_id, factory: :study_field
  end
end
