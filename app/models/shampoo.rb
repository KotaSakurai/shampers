class Shampoo < ApplicationRecord
  mount_uploader :image, ImageUploader
  has_many :tags
end
