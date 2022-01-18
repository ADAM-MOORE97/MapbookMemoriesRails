class Location < ApplicationRecord
    belongs_to :user 
    has_many :trips, dependent: :destroy
    validates :custom_name, uniqueness: true, presence: true
    validates :mapped_address, presence: true
    validates :place_type, presence: true
    validates :latitude, presence: true
    validates :longitude, presence: true
    validates :description, presence: true
end
