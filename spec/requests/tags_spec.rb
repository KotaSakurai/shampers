require 'rails_helper'

RSpec.describe "Tags", type: :request do
  let(:tag) { create(:tag) }

  describe '#destroy' do
    before do
      create(:user)
      create(:shampoo)
      delete tag_path(tag), params: { id: tag.id }
    end


    it { expect(response).to redirect_to root_url }
  end
end
