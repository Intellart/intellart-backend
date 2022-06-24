require 'rails_helper'

RSpec.describe NftCollectionSerializer do
  before :each do
    @collection = FactoryBot.create(:nft_collection)
    @serializer = NftCollectionSerializer.new(@collection)
    @serialization = ActiveModelSerializers::Adapter.create(@serializer)
  end

  describe '#as_json' do
    subject { JSON.parse(@serialization.to_json) }

    it 'root should be of type Hash' do
      expect(subject).to be_kind_of(Hash)
    end

    context 'attributtes' do
      it 'should have id and collection_name' do
        expect(subject).to have_key('id')
        expect(subject).to have_key('collection_name')
      end
    end
  end
end
