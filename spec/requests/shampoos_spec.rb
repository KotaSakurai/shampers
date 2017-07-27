require 'rails_helper'

describe 'Shampoos', type: :request do
  let(:shampoo) { create(:shampoo) }

  describe '#show' do
    before do
      get shampoo_path(shampoo)
    end

    it { expect(response).to render_template 'show' }
  end

  describe '#create' do
    context 'valid shampoo post' do
      let(:shampoo) { build(:shampoo) }
      let(:image) { fixture_file_upload Rails.root.join('spec', 'fixtures', 'files', 'test.png'), 'image/png' }

      before do
        post shampoos_path, params: { shampoo: { name: shampoo.name, price: shampoo.price, storage: shampoo.storage, image: image } }
      end

      it { expect(response).to redirect_to shampoo_path(assigns(:shampoo)) }
      it { expect(flash[:info]).not_to be_nil }
    end

    context 'invalid shampoo price post' do
      let(:shampoo) { build(:shampoo) }

      let(:price) { 9000 }
      let(:image) { fixture_file_upload Rails.root.join('spec', 'fixtures', 'files', 'test.png'), 'image/png' }

      before do
        post shampoos_path, params: { shampoo: { name: shampoo.name, price: price, storage: shampoo.storage, image: image } }
      end

      it { expect(response).to render_template 'new' }
      it { expect(flash[:info]).to be_nil }
    end
  end
end
