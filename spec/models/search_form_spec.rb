require 'rails_helper'

RSpec.describe SearchForm, type: :model do
  let(:word) { SearchForm.new(search_word: tag_search) }

  before do
    create(:user)
    create(:shampoo)
    create(:tag)
  end

  context "tag search not find" do
    let(:tag_search) { "#aaa" }

    it { expect(word.search).to be_empty }
  end

  context "tag search" do
    let(:tag_search) { "#good" }

    it { expect(word.search).not_to be_empty }
  end

  context "shampoo search not find" do
    let(:tag_search) { "aaa" }

    it { expect(word.search).to be_empty }
  end

  context "shampoo search found" do
    let(:tag_search) { "revuel" }

    it { expect(word.search).not_to be_empty }
  end
end
