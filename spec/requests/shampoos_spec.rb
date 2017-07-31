require 'rails_helper'

describe 'Shampoos', type: :request do
  let(:shampoo) { create(:shampoo) }

  describe '#index' do
    before { get shampoos_path }

    it { expect(response).to render_template 'index' }
  end

  describe '#edit' do
    before { get edit_shampoo_path(shampoo) }

    it { expect(response).to render_template 'edit' }
  end

  describe '#new' do
    before { get new_shampoo_path }

    it { expect(response).to render_template 'new' }
  end

  describe '#show' do
    context 'when correct path' do
      before do
        get shampoo_path(shampoo)
      end

      it { expect(response).to render_template 'show' }
    end

    context 'when not correct path' do
      before { get shampoo_path(id: 20) }

      it { expect(response).to redirect_to root_path }
    end
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

      let(:price) { 100000 }
      let(:image) { fixture_file_upload Rails.root.join('spec', 'fixtures', 'files', 'test.png'), 'image/png' }

      before do
        post shampoos_path, params: { shampoo: { name: shampoo.name, price: price, storage: shampoo.storage, image: image } }
      end

      it { expect(response).to render_template 'new' }
      it { expect(flash[:info]).to be_nil }
    end
  end

  describe '#update' do
    let(:image) { fixture_file_upload Rails.root.join('spec', 'fixtures', 'files', 'test.png'), 'image/png' }

    context 'when valid update' do
      before { patch shampoo_path(shampoo), params: { shampoo: { name: shampoo.name, price: 300, storage: 400, image: image } } }

      it { expect(response).to redirect_to shampoo_path shampoo }
    end

    context 'when not find shampoo ' do
      before { patch shampoo_path(shampoo), params: { shampoo: { name: '', price: 300000, storage: 400, image: image } } }

      it { expect(response).to render_template 'edit' }
    end
  end

  describe '#destroy' do
    context 'when valid destroy' do
      before { delete shampoo_path(shampoo) }

      it { expect(response).to redirect_to root_path }
    end
  end
end
