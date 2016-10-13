class Clue < ActiveRecord::Base
  # has_many :game_clues
  belongs_to :category
  # accepts_nested_attributes_for :game_clues

  def self.by_value(category_id)
    points_hash = Hash.new([])
    clues = Clue.where(category_id: category_id)
    [100, 200, 400, 800, 1000].each do |points|
      points_hash[points] = clues.where(value: points)
    end
    points_hash
  end
end
