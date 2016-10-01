class GameSerializer < ActiveModel::Serializer
  attributes :id, :user_id
  has_many :categories
  belongs_to :user
end
