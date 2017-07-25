class Tag < ApplicationRecord
  validates :name, presence: true
  validates :shampoo_id, presence: true
  validates :user_id, presence: true
  belongs_to :user
  belongs_to :shampoo

  def self.search(search_word)
    if search_word
      Tag.where(['name LIKE ?', "#{sanitize_sql_like(search_word)}"])
    else
      Tag.none
    end
  end
end
