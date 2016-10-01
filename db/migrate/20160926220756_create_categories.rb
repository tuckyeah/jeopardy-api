class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.boolean :complete, default: false

      t.timestamps null: false
    end
  end
end
