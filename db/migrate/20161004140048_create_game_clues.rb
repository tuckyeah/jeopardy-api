class CreateGameClues < ActiveRecord::Migration
  def change
    create_table :game_clues do |t|
      t.references :game, index: true, foreign_key: true
      t.references :clue, index: true, foreign_key: true
      t.references :response, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
