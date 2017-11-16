require 'rails_helper'

RSpec.describe Tag, type: :model do
  subject { tag }

  describe 'create tags' do
    let(:tag) { build(:tag, params) }

    context 'when not presence tag' do
      let(:params) { { name: '' } }

      it { is_expected.to be_invalid }
    end

    context 'when not valid user_id' do
      let(:params) { { user_id: 2000 } }

      it { is_expected.to be_invalid }
    end

    context 'when not valid shampoo_id' do
      let(:params) { { shampoo_id: 2000 } }

      it { is_expected.to be_invalid }
    end

    context 'when name duplicate' do
      let(:duplicate_tag) { build(:tag, name: "so good") }
      let(:params) { { name: "so good" } }

      before { duplicate_tag.save }

      it { is_expected.to be_invalid }
    end

    context 'when name duplicate tag name and shampoo_id for uniquness scope' do
      let(:shampoo) { create(:shampoo) }
      let(:first_tag) { create(:tag, shampoo_id: shampoo.id) }
      let(:params) { { name: first_tag.name, shampoo_id: shampoo.id } }

      before do
        create(:user)
        tag.save
      end

      it { is_expected.to be_invalid }
    end
  end

  describe 'search method' do
    before do
      create(:user)
      create(:shampoo)
      create(:tag)
    end

    context "when search hit" do
      let(:search_tag) { "good" }

      it { expect(Tag.search(search_tag)).not_to be_empty }
    end

    context "when search no hit" do
      let(:search_tag) { "aaa" }

      it { expect(Tag.search(search_tag)).to be_empty }
    end

    context "when no search word" do
      let(:search_tag) { '' }

      it { expect(Tag.search(search_tag)).to be_empty }
    end
  end
end
