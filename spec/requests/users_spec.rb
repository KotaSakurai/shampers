require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe '#new' do
    before { get signup_path }
    subject { response }

    it { is_expected.to be_success }
    it { is_expected.to render_template 'new' }
  end

  describe '#create' do
    let(:user) { build(:user) }

    before do
      post users_path, params: { user: { name: user.name, email: user.email,
                                         password: user.password,
                                         password_confirmation: user.password_confirmation,
                                         age: 3,
                                         gender: 1 } }
    end

    context 'with correct user info not activate' do
      it { expect(flash[:info]).not_to be_nil }
      it { expect(session[:user_id]).to be_nil }
    end

    context 'with wrong email' do
      let(:email) { 'aaa' }

      it { expect(flash[:success]).to be_nil }
      it { expect(session[:user_id]).to be_nil }
    end
  end

  describe '#edit' do
    subject { response }

    let(:user) { create(:user, :activated) }

    context 'when logged in user access egit path' do
      before do
        get login_path
        post login_path, params: { session: { email: user.email, password: user.password } }
        get edit_user_path(user)
      end

      it { is_expected.to be_success }
      it { is_expected.to render_template 'edit' }
    end

    context 'when not logged in user access egit path' do
      before do
        get edit_user_path(user)
      end

      it { is_expected.to redirect_to login_path }
    end
  end

  describe '#update' do
    let(:user) { create(:user, :activated) }

    before do
      get login_path
      post login_path, params: { session: { email: user.email, password: user.password } }
      # get edit_user_path(user)
    end

    context 'when update valid name' do
      let(:change_name) { 'sakurai' }

      before do
        put user_path(user), params: { user: { name: change_name } }
        user.reload
      end

      it { expect(user.name).to eq 'sakurai' }
      it { is_expected.to redirect_to user_path(user) }
    end

    context 'when cant update too long invalid name' do
      let(:long_name) { "a" * 300 }

      before do
        put user_path(user), params: { user: { name: long_name } }
        user.reload
      end
      it { expect(user.name).not_to eq long_name }
      it { expect(response.status).to eq 200 }
      it { is_expected.to render_template 'edit' }
    end

    context 'when update valid email' do
      let(:change_email) { 'sakurai@sakurai.com' }

      before do
        put user_path(user), params: { user: { email: change_email } }
        user.reload
      end

      it { expect(user.email).to eq change_email }
      it { is_expected.to redirect_to user_path(user) }
    end
  end

  describe '#show' do
    subject { response }

    let(:user) { create(:user) }

    before { get user_path(user) }

    it { is_expected.to render_template 'show' }
    it { expect(response.body).to match user.name }
  end

  describe '#destroy' do
    let(:user) { create(:user, :activated) }
    let!(:other_user) { create(:other_user) }

    before do
      post login_path, params: { session: { email: user.email, password: user.password } }
      delete user_path(other_user), params: { id: other_user.id }
    end

    it { expect(response).to redirect_to root_url }
    # it { expect { delete user_path(id: other_user.id) }.to change{ User.count }.by(-1) }
  end
end
