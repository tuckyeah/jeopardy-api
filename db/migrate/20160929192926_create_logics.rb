class CreateLogics < ActiveRecord::Migration
  def change
    create_table :logics do |t|

      t.timestamps null: false
    end
  end
end
