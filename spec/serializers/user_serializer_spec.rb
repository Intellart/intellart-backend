require 'rails_helper'

RSpec.describe UserSerializer do
  before :each do
    @user = FactoryBot.create(:user)
    @serializer = UserSerializer.new(@user)
    @serialization = ActiveModelSerializers::Adapter.create(@serializer)
  end

  describe '#as_json' do
    subject { JSON.parse(@serialization.to_json) }

    it 'root should be of type Hash' do
      expect(subject).to be_kind_of(Hash)
    end

    context 'attributtes' do
      it 'should have id, email, first_name, last_name, full_name, orcid_id, study_field, profile_img, social_links, created_at, updated_at' do
        expect(subject).to have_key('id')
        expect(subject).to have_key('email')
        expect(subject).to have_key('first_name')
        expect(subject).to have_key('last_name')
        expect(subject).to have_key('full_name')
        expect(subject).to have_key('orcid_id')
        expect(subject).to have_key('study_field')
        expect(subject).to have_key('profile_img')
        expect(subject).to have_key('social_links')
        expect(subject).to have_key('created_at')
        expect(subject).to have_key('updated_at')
      end
    end
  end
end
