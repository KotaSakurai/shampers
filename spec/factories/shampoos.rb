include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :shampoo do
    name "revuel"
    price 100
    storage 300
    image File.open(File.join(Rails.root, '/spec/fixtures/files/test.png'))
  end
end
