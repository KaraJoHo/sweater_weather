class Api::V1::ForecastController < ApplicationController 
  def index 
    if params[:location] == ""
      render json: ErrorSerializer.new("No location provided").bad_request, status: 400
    else
      render json: ForecastSerializer.new(ForecastFacade.new(params[:location]).forecast_for_given_location)
    end
  end
end