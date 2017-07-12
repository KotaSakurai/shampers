require 'rails_helper'

describe 'Sessions', type: :request do
  describe '#new' do
    before do
      get login_path
    end
    it { expect(response).to render_template(:new) }
    it { expect(response).to be_success }
  end

  describe '#create' do
    let!(:user) { create(:user) }
    let(:post_email) { user.email }
    let(:post_password) { user.password }

    context 'success session create' do
      before do
        post login_path, params: { session: { email: post_email, password: post_password } }
      end
      it { expect(response).to redirect_to user_path(user) }
      it { expect(session[:user_id]).to eq user.id } # sessionが保存されているか？
    end

    context 'with wrong email' do
      let(:post_email) { "aa.." }

      before {
        post login_path, params: { session: { email: post_email, password: user.password } }
      }
      it { expect(response).to render_template 'new' }
      it { expect(session[:user_id]).to be_nil }
    end

    # context 'with not activated user ' do
    #   let(:user) { create(:user, activated: false) }

    #   before do
    #     post login_path, params: { session: { email: user.email, password: user.password } }
    #   end
    #   it { expect(response).to redirect_to root_path }
    #   it { expect(session[:user_id]).to be_nil }
    # end

    # context 'not activate user' do
    #   before do
    #     delete logout_path
    #     user.update_attributes(activated: false)
    #     post login_path, params: { session: { email: user.email, password: user.password } }
    #   end
    #   it { expect(response).to redirect_to root_url }
    # end
  end

  describe '#destroy' do
    let!(:user) { create(:user) }

    before do
      post login_path, params: { session: { email: user.email, password: user.password } }
      delete logout_path
    end
    it { expect(response).to redirect_to(root_url) }
    it { expect(session[:user_id]).to be_nil }
  end
end
