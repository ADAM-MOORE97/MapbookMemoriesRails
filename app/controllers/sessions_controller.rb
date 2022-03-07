class SessionsController < ApplicationController


    def create
   puts params
        user = User.find_by(username: params[:username])
        if user&.authenticate(params[:password])

          token= issue_token(user)

          cookies.signed[:token] = {value: token, httponly: true, expires: 30.seconds.from_now}
     
          render json: user, status: :ok
        else
          render json: { errors: ["Invalid login credentials."] }, status: :unauthorized
        end
      end
    
      def destroy
        cookies.delete(:token)
        head :no_content
      end
      private
      def session_params
          params.permit(:username, :password)
      end
      
end