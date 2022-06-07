FactoryBot.define do
  factory :wallet do
    association :user_id, factory: :user
  end
end
