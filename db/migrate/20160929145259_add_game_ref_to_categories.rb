class AddGameRefToCategories < ActiveRecord::Migration
  def change
    add_reference :categories, :game, index: true, foreign_key: true
  end
end
