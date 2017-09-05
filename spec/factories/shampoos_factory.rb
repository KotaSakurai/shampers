include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :shampoo do
    name "revuel"
    price 100
    storage 300
    # image Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/file/test.jpg'))
    image { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', 'files', 'test.jpg'), 'image/jpg') }
    # image { fixture_file_upload Rails.root.join('spec', 'fixtures', 'files', 'test.jpg'), 'image/jpg' }
    # image File.open(File.join(Rails.root, '/spec/fixtures/files/test.png'))
  end
end
