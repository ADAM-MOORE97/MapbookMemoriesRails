class TripSerializer < ActiveModel::Serializer
  include JSONAPI::Serializer
  attributes :id, :name, :start_date, :end_date, :taken, :description, :attachment_urls
end
