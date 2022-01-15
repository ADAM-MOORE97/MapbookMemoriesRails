class TripSerializer < ActiveModel::Serializer
  attributes :id, :name, :start_data, :end_date, :taken, :description
end
