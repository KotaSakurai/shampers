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

    context "correct email" do
      before do
        post password_resets_url, params: { password_reset: { email: user.email } }
        user.reload
      end

      it { is_expected.to redirect_to root_path }
      it { expect(user.reset_digest).not_to be_nil }
      it { expect(flash[:info]).not_to be_nil }
    end

    context "incorrect email" do
      let(:wrong_email) { "wrong@wrong.com" }

      before do
        post password_resets_url, params: { password_reset: { email: wrong_email } }
      end

      it { is_expected.to render_template 'new' }
      it { expect(user.reset_digest).to be_nil }
      it { expect(flash[:info]).to be_nil }
    end
  end
end
