class Shampoo < ApplicationRecord
  mount_uploader :image, ImageUploader
  has_many :tags

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :price, presence: true, numericality: { less_than: 1000 }
  validates :storage, presence: true, numericality: { less_than: 1000 }
  validates :image, presence: true

  def self.search(search)
    if search
      Shampoo.where(['name LIKE ?', "%#{sanitize_sql_like(search)}%"])
    else
      Shampoo.all
    end
  end
end
