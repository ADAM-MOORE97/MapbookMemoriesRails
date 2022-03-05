class ApplicationController < ActionController::API
    rescue_from ActiveRecord::RecordInvalid, with: :render_record_invalid
    rescue_from ActiveRecord::RecordNotFound, with: :render_record_not_found

    def jwt_key
      Rails.application.credentials.jwt_secret
    end

    def issue_token(user)
      JWT.encode({user_id: user.id}.merge(exp: 30.minutes.from_now.to_i), jwt_key, "HS256")
  end

  def decoded_token
      begin
          JWT.decode(token, jwt_key, true, { :algorithm => 'HS256' })
      rescue => exception
          [{error: "Invalid Token"}]
      end    
  end
  
  def token
      request.headers["Authorization"]
  end

  def user_id
      decoded_token.first["user_id"]
  end

  def current_user
      user ||= User.find_by(id: user_id)
  end

  def logged_in?
      !!current_user
  end






    def render_record_invalid(invalid)
        render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
    end
  
    def render_record_not_found(error)
      render json: { errors: [error] }, status: :not_found
    end
end
