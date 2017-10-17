class Shampoo < ApplicationRecord
  mount_uploader :image, ImageUploader
  has_many :tags, dependent: :destroy

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :price, presence: true, numericality: { less_than: 10000 }
  validates :storage, presence: true, numericality: { less_than: 1000 }
  validates :image, presence: true

  def self.search(search_word)
    unless search_word.empty?
      Shampoo.where(['name == ?', "#{sanitize_sql_like(search_word)}"]).to_a
    else
      # Shampoo.none
      []
    end
  end
end
