class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :score
end
