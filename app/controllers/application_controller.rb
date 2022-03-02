class ApplicationController < ActionController::API
    include ActionController::Cookies
    include ActionController::RequestForgeryProtection
        protect_from_forgery with: :exception  
    skip_before_action :verify_authenticity_token
 
  
    rescue_from ActiveRecord::RecordInvalid, with: :render_record_invalid
    rescue_from ActiveRecord::RecordNotFound, with: :render_record_not_found


    def current_user
     @current_user = User.find(session[:user_id])
    
    end

    def render_record_invalid(invalid)
        render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
    end
  
    def render_record_not_found(error)
      render json: { errors: [error] }, status: :not_found
    end
end
