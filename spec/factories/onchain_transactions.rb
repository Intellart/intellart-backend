FactoryBot.define do
  factory :onchain_transaction do
    timestamp { '2022-15-04 12:00:00' }
    buyer_address { 'addr1q8usdmn7lz7tgvn6xd99jc4ysrgyj83t4hvmvket4w28v8ml072qh4vkn5euu9s8h0g70stvwfh0cshtxf7502hta72qu3vxru' }
    seller_address { 'addr1vyasfpcn39d6l3rrn8hpuumcdypuj8dkkudur4ethc44ueqrjd9y8' }
    price { 76.0 }
    transaction_id { 'c2882f40e4512572bb8594e467d84fccceb0cff17e62f0d8bcb807f79a7c97a0' }
  end
end
