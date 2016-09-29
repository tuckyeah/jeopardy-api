class Game < ActiveRecord::Base
  after_create :assign_id
  has_many :categories, dependent: :destroy
  belongs_to :user
  accepts_nested_attributes_for :categories

  def assign_id
    puts "Game id is: #{self.id}"
    game_id = self.id
    @categories = Category.where(id: Category.pluck(:id).sample(3))
    @categories.map { |cat| cat.game_id = game_id }
    @categories.each { |cat| cat.save }
  end

# on game creation, pick five categories and update those game_ids to reflect
# the id of the new game, so they are linked



end
