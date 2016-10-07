class Clue < ActiveRecord::Base
  belongs_to :category
  # validates :question, uniqueness: true
end
