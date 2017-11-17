class CreateShampoos < ActiveRecord::Migration[5.1]
  def change
    create_table :shampoos do |t|
      t.string :name
      t.integer :price
      t.integer :storage
      t.string :image
      t.string :amazon_url

      t.timestamps
    end
  end
end
