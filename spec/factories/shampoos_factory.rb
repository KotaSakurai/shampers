include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :shampoo do
    name "revuel"
    price 100
    storage 300
    image { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', 'files', 'test.jpg'), 'image/jpg') }
  end
end
