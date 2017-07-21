class Shampoo < ApplicationRecord
  mount_uploader :image, ImageUploader
  has_many :tags

  validates :name, presence: true
  validates :price, presence: true
  validates :storage, presence: true
  validates :image, presence: true
end
