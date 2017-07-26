require 'rails_helper'

RSpec.describe PasswordResetsController, type: :controller do
  describe "GET #create" do
    let(:user) { create(:user) }

    context "returns http success" do
      before {
        binding.pry
        post password_resets_url, params: { password_reset: { email: user.email } }
      }
      it { expect(response).to have_http_status(:success) }
    end

    context "when user reset password with orrect password" do
    end
  end

  describe "GET #update" do
    it "returns http success" do
      get :update
      expect(response).to have_http_status(:success)
    end
  end
end
