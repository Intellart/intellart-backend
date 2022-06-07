FactoryBot.define do
  factory :nft_endorser do
    fingerprint { 'asset1hr5j2pulx3273er0dpcz9yu6xzeuypsc9nq2au' }
    association :user_id, factory: :user
  end
end
