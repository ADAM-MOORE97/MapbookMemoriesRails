class ApplicationController < ActionController::API
  include ::ActionController::Cookies
    rescue_from ActiveRecord::RecordInvalid, with: :render_record_invalid
    rescue_from ActiveRecord::RecordNotFound, with: :render_record_not_found

    def jwt_key
      Rails.application.credentials.jwt_secret
    end

    def issue_token(user)
      JWT.encode({user_id: user.id}, jwt_key, "HS256")
  end

  def current_user

    cookie = cookies.signed[:token]
     begin
        user_id=JWT.decode(cookie, jwt_key)[0].values[0]

    rescue => exception
        [{error: "Invalid Token"}]
    end   
  
    return User.find_by(id: user_id)

  end






    def render_record_invalid(invalid)
        render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
    end
  
    def render_record_not_found(error)
      render json: { errors: [error] }, status: :not_found
    end
end
