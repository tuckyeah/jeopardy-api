class Category < ActiveRecord::Base
  has_many :clues
  belongs_to :game
end
