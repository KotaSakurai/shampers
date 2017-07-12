require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }
  subject { user }

  describe '#new' do
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

    context 'email duplicate' do
      let(:duplicate_user) { user.dup }

      before do
        # duplicate_user.email = user.email
        duplicate_user.save
      end
      it { is_expected.to be_invalid }
    end

    context 'email saved lower-case' do
      before do
        user.email = "Foo@ExAMPle.CoM"
        user.save
      end
      it { is_expected.to be_valid }
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
end
