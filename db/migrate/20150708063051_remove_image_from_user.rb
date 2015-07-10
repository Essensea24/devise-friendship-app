class RemoveImageFromUser < ActiveRecord::Migration
  def change
    remove_column :users, :Image, :string
  end
end
