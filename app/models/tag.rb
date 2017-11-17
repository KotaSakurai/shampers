class Tag < ApplicationRecord
  validates :name, presence: true, :uniqueness => { :scope => :shampoo_id }
  validates :shampoo_id, presence: true
  belongs_to :shampoo

  def self.search(search_word)
    unless search_word.empty?
      Tag.where(['name = ?', "#{sanitize_sql_like(search_word)}"]).to_a
    else
      # Tag.none
      []
    end
  end
end
