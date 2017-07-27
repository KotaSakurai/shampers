require 'rails_helper'

RSpec.describe "Tags", type: :request do
  let(:tag) { build(:tag) }
  let(:user) { create(:user, :activated) }
  let(:shampoo) { create(:shampoo) }

  before do
    login_as user
    post tags_path, params: { tag: { name: params, user_id: user.id, shampoo_id: shampoo.id } }
  end

  describe '#create' do
    context 'when post correct tag' do
      let(:params) { tag.name }

      it { expect(response).to redirect_to root_url }
      it { expect(flash[:info]).not_to be_nil }
    end

    context 'when post blank tag' do
      let(:blank_tag) { "" }
      let(:params) { blank_tag }

      it { expect(response).to redirect_to root_url }
      it { expect(flash[:danger]).not_to be_nil }
    end
  end

  describe '#destroy' do
    let(:params) { tag.name }

    before do
      delete tag_path(assigns(:tag)), params: { id: assigns(:tag).id }
    end

    it { expect(response).to redirect_to root_url }
  end
end
