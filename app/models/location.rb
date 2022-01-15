class Location < ApplicationRecord
    belongs_to :user 
    has_many :trips, dependent: :destroy
    validates :name, uniqueness: true
    validates :latitude, presence: true
    validates :longitude, presence: true
    validates :description, presence: true
end
