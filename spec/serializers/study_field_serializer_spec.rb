require 'rails_helper'

RSpec.describe StudyFieldSerializer do
  before :each do
    @study_field = FactoryBot.create(:study_field)
    @serializer = StudyFieldSerializer.new(@study_field)
    @serialization = ActiveModelSerializers::Adapter.create(@serializer)
  end

  describe '#as_json' do
    subject { JSON.parse(@serialization.to_json) }

    it 'root should be of type Hash' do
      expect(subject).to be_kind_of(Hash)
    end

    context 'attributtes' do
      it 'should have id and field_name' do
        expect(subject).to have_key('id')
        expect(subject).to have_key('field_name')
      end
    end
  end
end
