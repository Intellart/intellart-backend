require 'rails_helper'

RSpec.describe CategorySerializer do
  before :each do
    @category = FactoryBot.create(:category)
    @serializer = CategorySerializer.new(@category)
    @serialization = ActiveModelSerializers::Adapter.create(@serializer)
  end

  describe '#as_json' do
    subject { JSON.parse(@serialization.to_json) }

    it 'root should be of type Hash' do
      expect(subject).to be_kind_of(Hash)
    end

    context 'attributtes' do
      it 'should have id and category_name' do
        expect(subject).to have_key('id')
        expect(subject).to have_key('category_name')
      end
    end
  end
end
