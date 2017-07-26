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
      let(:image ) { File.open(File.join(Rails.root, '/spec/fixtures/files/test.png')) }

      before do
        post shampoos_path, params: { shampoo: { name: shampoo.name, price: shampoo.price, storage: shampoo.storage, image: image } }
      end

      it { expect(response).to have_http_status(200) }
      it { expect(flash[:info]).not_to be_nil }
    end

    context 'invalid shampoo post' do
      let(:shampoo) { build(:shampoo) }

      let(:name) { "shampooName" } 
      let(:price) { 9000 }
      let(:storage) { 4500 }
      let(:image ) { File.open(File.join(Rails.root, '/spec/fixtures/files/test.png')) }

      before do
        post shampoos_path, params: { shampoo: { name: name, price: price, storage: storage, image: shampoo.image } }
      end

      it { expect(response).to render_template 'new' }
      it { expect(flash[:info]).to be_nil }
    end
  end
end