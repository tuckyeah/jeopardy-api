class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.references :game, index: true, foreign_key: true
      t.string :user_answer
      t.integer :user_id
      t.boolean :correct, default: false
      t.string :clue_answer

      t.timestamps null: false
    end
  end
end
