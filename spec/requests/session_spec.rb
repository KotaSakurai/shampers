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

    context 'when no remember_me ' do
      before do
        get login_path
        post login_path, params: { session: { email: user.email, password: user.password, remember_me: 0 } }
      end
      it { expect(response).to redirect_to user_path(user) }
      it { expect(cookies['remember_token']).to eq nil }
    end

    context 'when remember_me ' do
      before do
        get login_path
        post login_path, params: { session: { email: user.email, password: user.password, remember_me: 1 } }
      end
      it { expect(response).to redirect_to user_path(user) }
      # test内はcookies[:remember_token]は常にnil
      it { expect(cookies['remember_token']).not_to eq nil }
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

  describe 'edit must need login' do
    let!(:user) { create(:user) }

    context 'when login 'do
      before do 
        get login_path
        post login_path, params: { session: { email: user.email, password: user.password } }
        get edit_user_path(user)
      end
      it { expect(response).to render_template 'edit'}
    end

    context 'when not login' do
      before do 
        get edit_user_path(user)
      end
      it { expect(response).to redirect_to login_path } 
    end
  end
end
