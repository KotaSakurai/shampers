require 'rails_helper'

RSpec.describe "Tags", type: :request do
  # let!(:user) { create(:user) }
  # let!(:shampoo) { create(:shampoo) }
  # let(:tag) { create(:tag) }

  describe '#destroy' do
    before do
      create(:user)
      create(:shampoo)
      delete tag_path(tag), params: { id: tag.id }
    end
    let(:tag) { create(:tag) }

    it { expect(response).to redirect_to root_url }

  end
end
