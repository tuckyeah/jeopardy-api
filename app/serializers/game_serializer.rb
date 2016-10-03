class GameSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :over
  has_many :categories
  belongs_to :user
end
