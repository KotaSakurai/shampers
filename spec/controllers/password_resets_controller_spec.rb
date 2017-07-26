require 'rails_helper'

RSpec.describe PasswordResetsController, type: :controller do
  describe "GET #create" do
    let(:user) { create(:user, :activated) }

    context "returns http success" do
      before {
        post :create, params: { password_reset: { email: user.email } }
      }
      it { expect(response).to have_http_status(302) }
    end

    # context "when user reset password with orrect password" do
    # end
  end

  # describe "GET #update" do
  #   it "returns http success" do
  #     get :update
  #     expect(response).to have_http_status(:success)
  #   end
  # end
end
