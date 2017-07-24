include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :shampoo do
    name "revuel"
    price 100
    storage 300
    image File.open(File.join(Rails.root, '/spec/fixtures/files/test.png'))
    # after :create do |b|
    #   b.update_column(:image, "foo/bar/baz.png")
    # end
    # image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'public', 'uploads', 'shampoo', 'image', '1','logo_image.jpg'), 'image/jpg') }
    # image attachment_file: File.open(Rails.root.join("public/uploads/shampoo/image/1/test.png"))
    # image { fixture_file_upload Rails.root.join('public', 'uploads', 'shampoo','image','1'), 'image/png' }
  end
end
