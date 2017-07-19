require 'rails_helper'

RSpec.describe User, type: :model do
  subject { user }

  describe 'create user' do
    let(:user) { build(:user, params) }

    context 'valid' do
      let(:params) { { name: 'foo' } }

      it { is_expected.to be_valid }
    end

    context 'name is invalid too long length' do
      let(:params) { { name: "a" * 51 } }

      it { is_expected.to be_invalid }
    end

    context 'email is invalid too long length' do
      let(:params) { { email: "a" * 255 + "example.com" } }

      it { is_expected.to be_invalid }
    end

    context 'when email is not valid format ",com"' do
      let(:params) { { email: 'user@example,com' } }

      it { is_expected.to be_invalid }
    end

    context 'when email is not valid format "_and_"' do
      let(:params) { { email: 'user@example,com' } }

      it { is_expected.to be_invalid }
    end

    context 'when email is not valid format "foo@bar_baz.com"' do
      let(:params) { { email: 'foo@bar_baz.com' } }

      it { is_expected.to be_invalid }
    end

    context 'when email is not valid format "foo@bar+baz.com"' do
      let(:params) { { email: 'foo@bar+baz.com' } }

      it { is_expected.to be_invalid }
    end

    context 'email duplicate' do
      let(:duplicate_user) { build(:user, email: "aaa@aaa.com") }
      let(:params) { { email: "aaa@aaa.com" } }

      before { duplicate_user.save }

      it { is_expected.to be_invalid }
    end

    context 'email saved lower-case' do
      let(:params) { { email: 'Foo@ExAMPle.CoM' } }

      before { user.save }
      it { expect(user.email).to eq "Foo@ExAMPle.CoM".downcase }
    end

    # context 'when password blank' do
    #   before do
    #     user.password = user.password_confirmation = " " * 6
    #   end
    #   it { is_expected.to be_invalid }
    # end

    context 'when confirmation blank' do
      let(:params) { { password_confirmation: "" } }

      it { is_expected.to be_invalid }
    end

    # context 'when password blank' do
    #   let(:params) { { password: "", password_confirmation: "" } }

    #   before do
    #     user.password  = ""
    #     user.password_confirmation = ""
    #     p user.password
    #     p user.password_confirmation
    #   end
    #   it { is_expected.to be_invalid }
    # end

    context 'when password minimum length' do
      let(:params) { { password: "a" * 4, password_confirmation: "a" * 4 } }

      it { is_expected.to be_invalid }
    end
  end

  describe 'user authenticate check' do
    let(:user) { build(:user) }

    context 'when remember_token nil' do
      it { expect(user.authenticated?(:remember, '')).to eq false }
    end
    context 'when valid remember_token' do
      before { user.remember }
      it { expect(user.authenticated?(:remember, user.remember_token)).to eq true }
    end
  end
end
