class TripSerializer < ActiveModel::Serializer
  include JSONAPI::Serializer
  attributes :id, :name, :start_data, :end_date, :taken, :description
end
