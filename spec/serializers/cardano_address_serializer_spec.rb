require 'rails_helper'

RSpec.describe CardanoAddressSerializer do
  User.destroy_all
  Wallet.destroy_all
  CardanoAddress.destroy_all

  before :each do
    @user = FactoryBot.create(:user)
    @wallet = FactoryBot.create(:wallet, user_id: @user.id)
    @cardano_address = FactoryBot.create(:cardano_address, wallet_id: @wallet.id)
    @serializer = CardanoAddressSerializer.new(@cardano_address)
    @serialization = ActiveModelSerializers::Adapter.create(@serializer)
  end

  describe '#as_json' do
    subject { JSON.parse(@serialization.to_json) }

    it 'root should be of type Hash' do
      expect(subject).to be_kind_of(Hash)
    end

    context 'attributes' do
      it 'should have id, address, dirty and wallet_id attributes' do
        expect(subject).to have_key('id')
        expect(subject).to have_key('address')
        expect(subject).to have_key('dirty')
        expect(subject).to have_key('wallet_id')
      end
    end
  end
end
