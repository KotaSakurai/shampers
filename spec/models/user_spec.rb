require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }
  subject { user }

  describe 'create user' do
    context 'valid' do
      it { is_expected.to be_valid }
    end

    context 'name is invalid too long length' do
      before do
        user.name = "a" * 51
      end
      it { is_expected.to be_invalid }
    end

    context 'email is invalid too long length' do
      before { user.email = "a" * 255 + "example.com" }
      it { is_expected.to be_invalid }
    end

    context 'when email is not valid format ",com"' do
      before { user.email = 'user@example,com' }
      it { is_expected.to be_invalid } 
    end

    context 'when email is not valid format "_and_"' do
      before { user.email = 'user_at_foo.org' }
      it { is_expected.to be_invalid } 
    end

    context 'when email is not valid format "foo@bar_baz.com"' do
      before { user.email = 'foo@bar_baz.com' }
      it { is_expected.to be_invalid } 
    end

    context 'when email is not valid format "foo@bar+baz.com"' do
      before { user.email = 'foo@bar+baz.com' }
      it { is_expected.to be_invalid } 
    end

    context 'email duplicate' do
      let(:duplicate_user) { user.dup }

      before do
        # duplicate_user.email = user.email
        duplicate_user.save
      end
      it { is_expected.to be_invalid }
    end

    context 'email saved lower-case' do
      let(:lower) { "Foo@ExAMPle.CoM" }
      before do
        user.email = lower
        user.save
      end
      it { expect(user.email).to eq lower.downcase }
    end

    context 'when password blank' do
      before do
        user.password = user.password_confirmation = " " * 6
      end
      it { is_expected.to be_invalid }
    end

    context 'when password minimum length' do
      before do
        user.password = user.password_confirmation = "a" * 5
      end
      it { is_expected.to be_invalid }
    end
  end

  describe 'user auth' do
    context 'authenticate method check' do
      # it { expect(user.authenticate("foobaa").to eq false )}
    end

    context 'user auth' do
      # it { expect(user.authenticated?(:remember, '')).to eq false }
    end
  end
end
