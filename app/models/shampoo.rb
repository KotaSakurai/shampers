class Shampoo < ApplicationRecord
  mount_uploader :image, ImageUploader
  has_many :tags, dependent: :destroy

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :price, presence: true, numericality: { less_than: 10000 }
  validates :storage, presence: true, numericality: { less_than: 1000 }
  validates :image, presence: true
end
