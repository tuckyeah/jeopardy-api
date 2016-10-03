class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :score, :name
end
