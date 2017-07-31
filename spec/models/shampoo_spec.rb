require 'rails_helper'

RSpec.describe Shampoo, type: :model do
  subject { shampoo }

  describe 'create shampoo' do
    let(:shampoo) { build(:shampoo, params) }

    context 'when not presence shampoo' do
      let(:params) { { name: '' } }

      it { is_expected.to be_invalid }
    end

    context 'when not presence price' do
      let(:params) { { price: '' } }

      it { is_expected.to be_invalid }
    end

    context 'when not  too expensive price' do
      let(:params) { { price: 30000 } }

      it { is_expected.to be_invalid }
    end

    context 'when not presence storage' do
      let(:params) { { storage: '' } }

      it { is_expected.to be_invalid }
    end

    context 'when not too much storage' do
      let(:params) { { storage: 3000 } }

      it { is_expected.to be_invalid }
    end

    context 'when not presence image' do
      let(:params) { { image: '' } }

      it { is_expected.to be_invalid }
    end

    context 'when name duplicate' do
      let(:duplicate_shampoo) { build(:shampoo, name: "aaaaaa") }
      let(:params) { { name: "aaaaaa" } }

      before { duplicate_shampoo.save }

      it { is_expected.to be_invalid }
    end
  end

  describe 'search method' do
    before do
      create(:user)
      create(:shampoo)
    end

    context "when search hit" do
      let(:search_tag) { "revuel" }

      it { expect(Shampoo.search(search_tag)).not_to be_empty }
    end

    context "when search no hit" do
      let(:search_tag) { "aaa" }

      it { expect(Shampoo.search(search_tag)).to be_empty }
    end

    context "when no search word" do
      let(:search_tag) { '' }

      it { expect(Shampoo.search(search_tag)).to be_empty }
    end
  end
end
