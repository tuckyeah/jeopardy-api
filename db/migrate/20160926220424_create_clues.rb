class CreateClues < ActiveRecord::Migration
  def change
    create_table :clues do |t|
      t.string :question
      t.string :answer
      t.string :value
      t.boolean :answered, default: false

      t.timestamps null: false
    end
  end
end
