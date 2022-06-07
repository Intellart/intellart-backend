FactoryBot.define do
  factory :rating do
    association :user_id, factory: :user
    association :rated_user_id, factory: :user
    rating { 5 }
  end
end
