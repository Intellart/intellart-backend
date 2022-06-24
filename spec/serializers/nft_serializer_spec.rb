require 'rails_helper'

RSpec.describe NftSerializer do
  before :each do
    @user = FactoryBot.create(:user)
    @wallet = FactoryBot.create(:wallet, user: @user)
    @cardano_address = FactoryBot.create(:cardano_address, wallet: @wallet)
    @onchain_tx = FactoryBot.create(:onchain_transaction)
    @nft_collection = FactoryBot.create(:nft_collection)
    @category = FactoryBot.create(:category)
    @nft = FactoryBot.create(:nft, owner_id: @user.id, category_id: @category, nft_collection_id: @nft_collection, onchain_transaction: @onchain_tx, cardano_address_id: @cardano_address)
    @serializer = NftSerializer.new(@nft)
    @serialization = ActiveModelSerializers::Adapter.create(@serializer)
  end

  describe '#as_json' do
    subject { JSON.parse(@serialization.to_json) }

    it 'root should be of type Hash' do
      expect(subject).to be_kind_of(Hash)
    end

    context 'attributtes' do
      it 'should have fingerprint, owner, asset_name, policy_id, tradeable, price, name, description, subject, category, nft_collection, onchain_transaction, cardano_address' do
        expect(subject).to have_key('fingerprint')
        expect(subject).to have_key('owner')
        expect(subject).to have_key('asset_name')
        expect(subject).to have_key('policy_id')
        expect(subject).to have_key('tradeable')
        expect(subject).to have_key('price')
        expect(subject).to have_key('name')
        expect(subject).to have_key('description')
        expect(subject).to have_key('subject')
        expect(subject).to have_key('category')
        expect(subject).to have_key('nft_collection')
        expect(subject).to have_key('onchain_transaction')
        expect(subject).to have_key('cardano_address')
        expect(subject).to have_key('created_at')
        expect(subject).to have_key('updated_at')
      end
    end
  end
end
