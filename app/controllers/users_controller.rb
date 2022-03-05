class UsersController < ApplicationController

    def show

        if current_user
                render json: current_user, status: :ok
        else 
            render json: { errors: ["Not authenticated"]}, status: :unauthorized
        end 
    end

    def create
        user = User.create!(user_params)
        if user.valid?
        token = issue_token(user)
        render json: {user: user, jwt: token}, status: :created
        else
        render json: user.errors.full_messages, status: :unprocessable_entity
       end
    end

    private
    def user_params
        params.permit(:username, :email, :password, :password_confirmation)
    end
end
# def current_user
#     cookie = cookies.signed[:token]
#    JWT.decode(cookie, jwt_key)
#    byebug
# end
def current_user
    cookie = cookies.signed[:token]
     begin
        user_id=JWT.decode(cookie, jwt_key)
    rescue => exception
        [{error: "Invalid Token"}]
    end   
    return User.find_by(id: user_id)
  end