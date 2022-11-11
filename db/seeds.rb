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
  first_name: 'First name',
  last_name: 'Last name',
  password: '123456',
  orcid_id: '0000-0000-0000-0001',
  study_field_id: 1
)
user2 = User.create!(
  email: 'test2@test.com',
  first_name: 'Name',
  last_name: 'Lastname',
  password: '123456',
  orcid_id: '0000-0000-0000-0002',
  study_field_id: 2
)

admin = Admin.create!(
  email: 'a@a.com',
  password: '123456'
)
addr1 = CardanoAddress.create!(address: '1testBBBBf12wc13r313fBt3fBBB', dirty: false)
addr2 = CardanoAddress.create!(address: '1tesAf12rf1AAAA', dirty: false)
addr3 = CardanoAddress.create!(address: '1testAAdawdawAAAAAwdj5zhvcxq5AAqawd126AA', dirty: false)

tag1 = Tag.create!(tag: 'test-tag')
tag2 = Tag.create!(tag: 'test-tag-2')


cat1 = Category.create!(category_name: 'test-category')


nft1 = Nft.create!(
  tradeable: true,
  price: 10.00000000,
  name: 'Mandala Sovereigns 4024',
  description: 'test-description',
  owner_id: 1,
  state: 'minted',
  asset_name: 'lion00024',
  policy_id: '8001dede26bb7cbbdwwde4ee5eae6568e763422e0a3c776b3f70878b03f1',
  fingerprint: 'asset1hr5j2pulx3273er0dpcz9yu6xzeuypsc9nq2au',
  cardano_address_id: 1
)
nft2 = Nft.create!(
  tradeable: false,
  price: 1000.00000000,
  name: 'request_for_minting title',
  description: 'request_for_minting description',
  owner_id: 2,
  state: 'request_for_minting',
  asset_name: 'lion00024',
  policy_id: '8001dede26bbdwad7cbbe4ee5eae6568e763422e0a3c776b3f70878b03f1',
  fingerprint: 'asset1hr5j2dwadwaz9yu6xzeuypsc9nq2au',
  cardano_address_id: 2
)

nft3 = Nft.create!(
  tradeable: false,
  price: 1000.00000000,
  name: 'request_for_sell title',
  description: 'request_for_sell description',
  owner_id: 2,
  asset_name: 'lion00024',
  state: 'request_for_sell',
  policy_id: '8001dede26bb7awdcbbe4ee5eae6568e763422e0a3c776b3f70878b03f1',
  fingerprint: 'asset1hr5jdwadwau6xzeuypsc9nq2au',
  cardano_address_id: 3
)



nft_tag1 = NftTag.create!(user_id: 1, tag_id: 1, fingerprint: 'asset1hr5j2pulx3273er0dpcz9yu6xzeuypsc9nq2au')
nft_tag2 = NftTag.create!(user_id: 2, tag_id: 2, fingerprint: 'asset1hr5j2pulx3273er0dpcz9yu6xzeuypsc9nq2au')

nft_endorse1 = NftEndorser.create!(user_id: 1, fingerprint: 'asset1hr5j2pulx3273er0dpcz9yu6xzeuypsc9nq2au')
nft_endorse2 = NftEndorser.create!(user_id: 2, fingerprint: 'asset1hr5j2pulx3273er0dpcz9yu6xzeuypsc9nq2au')

nft_like1 = NftLike.create!(user_id: 1, fingerprint: 'asset1hr5j2pulx3273er0dpcz9yu6xzeuypsc9nq2au')
nft_like2 = NftLike.create!(user_id: 2, fingerprint: 'asset1hr5j2pulx3273er0dpcz9yu6xzeuypsc9nq2au')

rating1 = Rating.create!(user_id: 1, rated_user_id: 2, rating: 5)
rating2 = Rating.create!(user_id: 2, rated_user_id: 1, rating: 1)
