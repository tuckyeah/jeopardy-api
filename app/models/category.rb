class Category < ActiveRecord::Base
  has_many :clues, -> { order(value: :asc) }
  belongs_to :game
end
