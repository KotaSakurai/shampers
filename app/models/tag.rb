class Tag < ApplicationRecord
  validates :name, presence: true, :uniqueness => { :scope => :shampoo_id }
  validates :shampoo_id, presence: true
  belongs_to :shampoo
end
