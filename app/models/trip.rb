class Trip < ApplicationRecord
 
    belongs_to :user 
    belongs_to :location
    has_many_attached :attachments 
    validates :name, uniqueness: true
    validates :name, presence: true
    validates :start_date, presence: true
    validates :end_date, presence: true
    validates :description, presence: true
  

    def attachment_urls
        attachments.map do |attached|
#   Rails.application.routes.url_helpers.rails_blob_path(attached, only_path: true)
  Rails.application.routes.url_helpers.rails_representation_url(attachrf.variant(resize: "200x200").processed, only_path: true)
            
        end
    end
 
end
# Rails.application.routes.url_helpers.rails_blob_path(attached.variant(resize_to_limit: [200,200]), only_path: true)