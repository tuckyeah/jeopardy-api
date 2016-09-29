class RemoveGameRefFromCategories < ActiveRecord::Migration
  def change
    remove_reference :categories, :game, index: true, foreign_key: true
  end
end
