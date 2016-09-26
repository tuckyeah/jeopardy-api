class CreateClues < ActiveRecord::Migration
  def change
    create_table :clues do |t|
      t.string :question
      t.string :answer
      t.string :value

      t.timestamps null: false
    end
  end
end
