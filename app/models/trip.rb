class Trip < ApplicationRecord
 
    belongs_to :user 
    belongs_to :location
    has_many_attached :attachments 
    validates :name, uniqueness: true
    validates :start_date, presence: true
    validates :end_date, presence: true
    validates :description, presence: true

    def attachment_urls
        attachments.map do |attached|
            Rails.application.routes.url_helpers.rails_blob_path(attached, only_path: true)
        end
    end
 
end
