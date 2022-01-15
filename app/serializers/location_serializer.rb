class LocationSerializer < ActiveModel::Serializer
  attributes :id, :name, :latitude, :longitude, :visited, :description
end
