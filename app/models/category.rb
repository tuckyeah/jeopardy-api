class Category < ActiveRecord::Base
  has_many :clues, -> { order(value: :desc) }
end
