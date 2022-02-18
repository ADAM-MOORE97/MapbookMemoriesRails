class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :email, :locations, :trips

end