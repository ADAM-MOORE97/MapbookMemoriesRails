class UsersController < ApplicationController

    # def show
    #     if @current_user
    #         render json: current_user, status: :ok
    #     else
    #         render json: ["No current session stored"], status: :unauthorized
    #     end
    # end
    def show
       
        if @current_user
            if params[:id] 
                render json: User.find(params[:id])
            elsif params[:username]
                render json: User.find_by!(username: params[:username])
            else
                render json: @current_user, status: :ok
            end
        else 
            render json: { errors: ["Not authenticated"] }, status: :unauthorized
        end 
    end

    def create
        user = User.create!(user_params)
        if user.valid?
        session[:user_id] = user.id 
        render json: user, status: :created
        else
        render json: user.errors.full_messages, status: :unprocessable_entity
       end
    end

    private
    def user_params
        params.permit(:username, :email, :password, :password_confirmation)
    end
end
