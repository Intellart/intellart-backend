require 'rails_helper'

RSpec.describe WalletSerializer do
  before :each do
    @user = FactoryBot.create(:user)
    @wallet = FactoryBot.create(:wallet, user: @user)
    @serializer = WalletSerializer.new(@wallet)
    @serialization = ActiveModelSerializers::Adapter.create(@serializer)
  end

  describe '#as_json' do
    subject { JSON.parse(@serialization.to_json) }

    it 'root should be of type Hash' do
      expect(subject).to be_kind_of(Hash)
    end

    context 'attributtes' do
      it 'should have id, user, total, used' do
        expect(subject).to have_key('id')
        expect(subject).to have_key('user')
        expect(subject).to have_key('total')
        expect(subject).to have_key('used')
      end
    end
  end
end
