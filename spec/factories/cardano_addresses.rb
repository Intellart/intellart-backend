FactoryBot.define do
  factory :cardano_address do
    address { 'addr1q8usdmn7lz7tgvn6xd99jc4ysrgyj83t4hvmvket4w28v8ml072qh4vkn5euu9s8h0g70stvwfh0cshtxf7502hta72qu3vxru' }
    dirty { true }
    association :wallet_id, factory: :wallet
  end
end
