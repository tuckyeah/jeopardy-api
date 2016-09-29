class AddUserRefToGames < ActiveRecord::Migration
  def change
    add_reference :games, :user, index: true, foreign_key: true
  end
end
