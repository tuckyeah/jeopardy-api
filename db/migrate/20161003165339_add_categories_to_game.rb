class AddCategoriesToGame < ActiveRecord::Migration
  def change
    add_column :games, :num_categories, :Integer
  end
end
