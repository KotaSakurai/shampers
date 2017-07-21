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
  end

  describe '#show' do
    let(:user) { create(:user) }
    before { get user_path(user) }
    subject { response }

    # context 'when not login' do
    #   it { is_expected.to render_template 'show'  }
    # end

    it { is_expected.to render_template 'show' }
    it { expect(response.body).to match user.name }
  end
end