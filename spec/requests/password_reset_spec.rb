require 'rails_helper'

describe 'PasswordReset', type: :request do
  describe '#new' do
    before { get new_password_reset_url }

    it { expect(response).to be_success }
    it { expect(response).to render_template 'new' }
  end

  describe '#create' do
    subject { response }

    let(:user) { create(:user) }

    context "when correct email" do
      before do
        post password_resets_url, params: { password_reset: { email: user.email } }
        user.reload
      end

      it { is_expected.to redirect_to root_path }
      it { expect(user.reset_digest).not_to be_nil }
      it { expect(flash[:info]).not_to be_nil }
    end

    context "when incorrect email" do
      let(:wrong_email) { "wrong@wrong.com" }

      before do
        post password_resets_url, params: { password_reset: { email: wrong_email } }
      end

      it { is_expected.to render_template 'new' }
      it { expect(user.reset_digest).to be_nil }
      it { expect(flash[:info]).to be_nil }
    end
  end

  describe '#update' do
    let(:user) { create(:user, :activated) }
    let(:assigns_user) { assigns(:user) }
    let(:token) { assigns_user.reset_token }

    before do
      post password_resets_url, params: { password_reset: { email: user.email } }
      patch password_reset_url(token), params: { user: { password: change_password, password_confirmation: change_password_confirmation }, email: user.email }
      user.reload
    end

    context "when correct reset password" do
      let(:change_password) { "hogehoge" }
      let(:change_password_confirmation) { "hogehoge" }

      it { is_expected.to redirect_to user_path user }
      it { expect(user.reset_digest).to be_nil }
      it { expect(flash[:success]).not_to be_nil }
    end

    context "when incorrect reset password" do
      let(:change_password) { "hoge" }
      let(:change_password_confirmation) { "hoge" }

      it { is_expected.to render_template 'edit' }
    end

    context "when unactive user" do
      let(:user) { create(:user) }
      let(:change_password) { "hogehoge" }
      let(:change_password_confirmation) { "hogehoge" }

      it { is_expected.to redirect_to root_path }
    end

    context "when invalid token" do
      let(:token) { "invalid" }
      let(:change_password) { "hogehoge" }
      let(:change_password_confirmation) { "hogehoge" }

      it { is_expected.to redirect_to root_path }
    end

    context "when over expiration" do
      let(:change_password) { "hogehoge" }
      let(:change_password_confirmation) { "hogehoge" }

      before do
        user.update_attributes(reset_digest: User.digest(user.reset_token), reset_sent_at: Time.zone.now - 5.hours)
        patch password_reset_url(token), params: { user: { password: change_password, password_confirmation: change_password_confirmation }, email: user.email }
      end

      it { is_expected.to redirect_to root_path }
    end
  end
end
