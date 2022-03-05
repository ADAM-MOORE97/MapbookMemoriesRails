class SessionsController < ApplicationController


    def create
        user = User.find_by(username: params[:username])
        if user&.authenticate(params[:password])
          response.headers["jwt"]= issue_token(user)
          render json: user, status: :ok
        else
          render json: { errors: ["Invalid login credentials."] }, status: :unauthorized
        end
      end
    
      def destroy
        session.delete(:user_id)
        head :no_content
      end
      
end