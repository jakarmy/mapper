class AddEmailColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :email, :string
    add_column :users, :name, :string
    add_column :users, :lastname, :string
    add_column :users, :deleted, :integer
    add_column :users, :admin, :boolean
    add_column :users, :hash_password, :string
    add_column :users, :token, :string
    add_column :users, :salt, :string
    add_column :users, :profile, :string
  end
end
