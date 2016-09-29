class AddPolymorphicRefToCategories < ActiveRecord::Migration
  def change
    add_reference :categories, :game_cats, polymorphic: true, index: true
  end
end
