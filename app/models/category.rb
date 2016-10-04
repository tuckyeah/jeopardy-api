class Category < ActiveRecord::Base
  has_many :clues, -> { order(value: :asc) }
  accepts_nested_attributes_for :clues
  belongs_to :game
end
