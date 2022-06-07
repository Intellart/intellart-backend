FactoryBot.define do
  factory :nft_tag do
    fingerprint { 'asset1hr5j2pulx3273er0dpcz9yu6xzeuypsc9nq2au' }
    association :user_id, factory: :user
    association :tag_id, factory: :tag
  end
end
