class CreateShampoos < ActiveRecord::Migration[5.1]
  def change
    create_table :shampoos do |t|
      t.string :name
      t.int :price
      t.int :storage
      t.string :image

      t.timestamps
    end
  end
end
