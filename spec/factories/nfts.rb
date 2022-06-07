FactoryBot.define do
  factory :nft do
    fingerprint { 'asset1hr5j2pulx3273er0dpcz9yu6xzeuypsc9nq2au' }
    policy_id { '8001dede26bb7cbbe4ee5eae6568e763422e0a3c776b3f70878b03f1' }
    asset_name { 'lion00024' }
    name { 'Test NFT' }
    tradeable { false }
    price { 100.00 }
    verified { false }
    description { 'Test description of an NFT.' }
    url { 'www.testnfts.com' }
    subject { 'Test subject' }
    association :owner_id, factory: :user
    association :category_id, factory: :category
    association :nft_collection_id, factory: :nft_collection
    association :onchain_transaction_id, factory: :onchain_transaction
    association :cardano_address_id, factory: :cardano_address
  end
end
