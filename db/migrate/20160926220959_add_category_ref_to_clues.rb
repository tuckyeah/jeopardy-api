class AddCategoryRefToClues < ActiveRecord::Migration
  def change
    add_reference :clues, :category, index: true, foreign_key: true
  end
end
