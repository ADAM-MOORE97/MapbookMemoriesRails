class LocationSerializer < ActiveModel::Serializer
  attributes :id, :custom_name, :mapped_address, :place_type, :latitude, :longitude, :visited, :description
end
