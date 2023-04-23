class Api::V1::RoadTripController < ApplicationController 
  def create 
    if !params[:api_key].present? || !User.all_keys.include?(params[:api_key])
       render json: ErrorSerializer.new("Key is incorrect or not present").bad_request, status: 401 
    else
      road_trip = RoadTripFacade.new(params[:origin], params[:destination]).road_trip
    
      render json: RoadTripSerializer.new(road_trip)
    end
  end
end