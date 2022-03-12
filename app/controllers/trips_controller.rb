class TripsController < ApplicationController
    def index
        if current_user
            render json: current_user.trips.all.map{|trip| TripSerializer.new(trip).serializable_hash[:data][:attributes]}, status: 200
        else 
            render json:{errors: ["You are not logged in"]}, status: :unauthorized
        end
    end
    def show
        if current_user

            trip = Trip.find_by!(id: params[:id])
       
            render json: TripSerializer.new(trip).serializable_hash[:data][:attributes], status: 200
        else
            render json: {errors: ["You are not logged in"]}, status: :unauthorized
        end
    end
    def create
        if current_user


        trip = Trip.new(trip_params)
        
        if trip.taken == true
            Location.find(params[:location_id]).update(visited: true)
            
            trip.to_json(include: [:attachments])
            trip.attachments.each do |image|
                image.tempfile = ImageProcessing::MiniMagick.source(image.tempfile).resize_to_limit(200, 200).call
            end
                if trip.save
                    render json: TripSerializer.new(trip).serializable_hash[:data][:attributes], status: 200
                 else
                     render json: {errors: trip.errors.full_messages}, status: :unprocessable_entity
                 end
        else
        trip.to_json(include: [:attachments])
        if trip.save
            render json: TripSerializer.new(trip).serializable_hash[:data][:attributes], status: 200
        else
            render json: {errors: trip.errors.full_messages}, status: :unprocessable_entity
        end
    end
else render json: {errors: ["You are not Logged in"]}, status: :unauthorized
end
    end
    def update
        if current_user
            trip = Trip.find_by(id: params[:id])
            if trip.taken == true
            Location.find(params[:location_id]).update(visited: true)
            trip.update!(trip_params)
            trip.to_json(include: [:attachments])
            render json: TripSerializer.new(trip).serializable_hash[:data][:attributes], status: 200
            else
                trip = Trip.find_by(id: params[:id])
                trip.update!(trip_params)
                trip.to_json(include: [:attachments])
                render json: TripSerializer.new(trip).serializable_hash[:data][:attributes], status: 200
            end
        else
            render json: {errors: ["You are not logged in"]}, status: :unauthorized
        end
    end
    def destroy
        trip = current_user.trips.find_by(id: params[:id])
        if current_user.id == trip.user_id
             trip.attachments.purge
             trip.destroy
            render json: {message: "deleted"}
        else
            render json: {errors: ["You are not logged in"]}, status: :unauthorized
        end
    end




    private

    def trip_params
        params.permit(:id, :name, :user_id, :location_id, :start_date, :end_date, :description, :taken, attachments: [])
    end
end
