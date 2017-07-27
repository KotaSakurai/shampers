include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :shampoo do
    name "revuel"
    price 100
    storage 300
    image { fixture_file_upload Rails.root.join('spec', 'fixtures', 'files', 'test.png'), 'image/png' }
    # image File.open(File.join(Rails.root, '/spec/fixtures/files/test.png'))
  end
end
