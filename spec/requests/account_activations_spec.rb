require 'rails_helper'

RSpec.describe 'account activation', type: :request do
  let(:user) { create(:user) }

  describe '#edit' do
    before do
      get edit_account_activation_path(token, email: user.email)
      user.reload
    end

    context 'when correct token' do
      let(:token) { user.activation_token }

      it { expect(user.activated).to be_truthy }
      it { expect(is_loggedin?).to be_truthy }
      it { expect(flash[:success]).not_to be_nil }
    end

    context 'when incorrect token' do
      let(:token) { "aaaaa" }

      it { expect(user.activated).to be_falsy }
      it { expect(is_loggedin?).to be_falsy }
      it { expect(flash[:success]).to be_nil }
    end
  end
end
