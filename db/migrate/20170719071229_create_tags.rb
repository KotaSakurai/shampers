class CreateTags < ActiveRecord::Migration[5.1]
  def change
    create_table :tags do |t|
      t.string :name
      t.integer :shampoo_id
      t.integer :user_id

      t.timestamps
    end
  end
end
