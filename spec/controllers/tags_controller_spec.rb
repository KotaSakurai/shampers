require 'rails_helper'

RSpec.describe TagsController, type: :controller do
  describe '#destroy' do
    before do
      create(:user)
      create(:shampoo)
    end

    let!(:tag) { create(:tag) }

    it { expect { delete :destroy, params: { id: tag.id } }.to change(Tag, :count).by(-1) }
  end
end
