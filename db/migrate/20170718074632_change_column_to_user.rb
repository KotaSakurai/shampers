class ChangeColumnToUser < ActiveRecord::Migration[5.1]
  def change
    change_column :users, :name, :string, null: false
    change_column :users, :email, :string, null: false
    remove_column :users, :password, :string
    remove_column :users, :password_confirmation, :string
    change_column :users, :password_digest, :string, null: false


    #change_column :users, :age, :integer, null
    #change_column :users, :gender, :integer, null: false

    change_column :users, :admin, :boolean, default: false
    change_column :users, :activated, :boolean, default: false

  end
end
