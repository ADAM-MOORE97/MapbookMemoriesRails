class Trip < ApplicationRecord
 
    belongs_to :user 
    belongs_to :location
    has_many_attached :attachments.each do |image|
        image.variant(resize_to_limit: [200,200])
    end
    validates :name, uniqueness: true
    validates :name, presence: true
    validates :start_date, presence: true
    validates :end_date, presence: true
    validates :description, presence: true
  

    def attachment_urls
        attachments.map do |attached|
  Rails.application.routes.url_helpers.rails_blob_path(attached, only_path: true)
#  attached.url
            
        end
    end
 
end
# Rails.application.routes.url_helpers.rails_blob_path(attached.variant(resize_to_limit: [200,200]), only_path: true)