class LocationsController < ApplicationController
    def index
        if @current_user
        locations = @current_user.locations.all
        render json: locations, status: :ok
        else 
            render json:[error: 'Not Found, No Current User'], status: 404
        end
    end
    def create

        if @current_user
            byebug
        location = @current_user.locations.create!(location_params)
            if location.valid?
                render json: location, status: :created
            else
                 render json: location.errors.full_messages, status: :unprocessable_entity
            end
        else
            render json: {errors: ["You are not Logged in"]}, status: :unauthorized
        end
    end
    def show
        if @current_user
            location = Location.find_by!(id: params[:id])
            render json: location.to_json(include: [:trips]), status: :ok
        else
            render json: {errors: ["You are not logged in"]}, status: :unauthorized
        end
    end
    def update
        if @current_user
            location = @current_user.location.find_by(id: params[:id])
            location.update!(location_params)
            # byebug
            render json: location, status: :ok
        else
            render json: {errors: ["You are not logged in"]}, status: :unauthorized
        end
    end
    def destroy
      if @current_user
        location = @current_user.locations.find(params[:id])
        location.destroy
        head :no_content
      end
    end
    private
  def location_params
      params.permit(:id, :custom_name, :mapped_address, :place_type, :latitude, :longitude, :visited, :description )
  end
end
