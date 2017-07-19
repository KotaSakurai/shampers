class Tag < ApplicationRecord
  validates :name, presence: true
  validates :shampoo_id, presence: true
  validates :user_id, presence: true
  belongs_to :user
end
