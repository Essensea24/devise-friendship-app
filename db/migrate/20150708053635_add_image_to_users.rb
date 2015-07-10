class AddImageToUsers < ActiveRecord::Migration
  def change
    add_column :users, :Image, :string
    add_column :users, :firstname, :string
    add_column :users, :lastname, :string
  end
end
