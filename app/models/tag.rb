class Tag < ApplicationRecord
  validates :name, presence: true
  validates :shampoo_id, presence: true
  validates :user_id, presence: true
  belongs_to :user
  belongs_to :shampoo

  def self.search(search)
    if search
      Tag.where(['name LIKE ?', "#{sanitize_sql_like(search)}"])
    else
      false
    end
  end
end
