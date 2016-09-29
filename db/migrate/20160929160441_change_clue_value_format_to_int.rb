class ChangeClueValueFormatToInt < ActiveRecord::Migration
  def change
    remove_column :clues, :value
    add_column :clues, :value, :integer
  end
end
