class Tag < ApplicationRecord
  validates :name, presence: true, uniqueness: { case_sensitive: true }
  validates :shampoo_id, presence: true
  validates :user_id, presence: true
  belongs_to :user
  belongs_to :shampoo
end
