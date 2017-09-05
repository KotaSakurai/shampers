require 'rails_helper'

RSpec.describe SearchForm, type: :model do
  subject { word.search }

  let(:word) { SearchForm.new(search_word: tag_search) }

  before do
    create(:user)
    create(:shampoo, name: "revuel")
    create(:tag, name: "aaa")
  end

  context "tag search not find" do
    let(:tag_search) { "#aaa" }

    it { is_expected.to be_empty }
  end

  context "tag search" do
    let(:tag_search) { "#good" }

    it { is_expected.not_to be_empty }
  end

  context "shampoo search not find" do
    let(:tag_search) { "aaa" }

    it { is_expected.to be_empty }
  end

  context "shampoo search found" do
    let(:tag_search) { "revuel" }

    it { is_expected.not_to be_empty }
  end
end
