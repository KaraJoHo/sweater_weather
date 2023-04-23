class Api::V1::RoadTripController < ApplicationController 
  def create 
    
    conn = Faraday.new(url: "https://www.mapquestapi.com")
    
    to_from_response = conn.get("/directions/v2/route?key=#{ENV["MAPQUEST_KEY"]}&from=#{params[:origin]}&to=#{params[:destination]}")
    
    trip = JSON.parse(to_from_response.body, symbolize_names: true)
    # require 'pry'; binding.pry
    if trip[:info][:statuscode] == 402
      travel_time = "impossible"
      weather_info_hash = {}
      road_trip = RoadTrip.new(params[:origin], params[:destination], travel_time, weather_info_hash)
    else
   
      travel_time = trip[:route][:formattedTime] #"04:42:52"

      duration_hours = travel_time[0..1].to_i #4
      duration_minutes = travel_time[3..4].to_i #42
      duration_seconds = travel_time[6..7].to_i #52

      
      days_to_arrive = (duration_hours / 24) #0
      hours_after_multiday_trip = (duration_hours - (days_to_arrive * 24)) #if travel time was "40:20:10"

      if days_to_arrive = 0
        time_at_arrival = Time.now + duration_hours.hours + duration_minutes.minutes + duration_seconds.seconds
      else 
        time_at_arrival = Time.now + hours_after_multiday_trip.hours + duration_minutes.minutes + duration_seconds.seconds
      end

      hour_at_arrival = time_at_arrival.strftime("%H:%M")
      hour_for_forecast = hour_at_arrival[0..1].to_i

      
      
      #weather_for_destination[:forecast][:forecastday][days_to_arrive][:hour][duration_hours][hour_for_forecast]
      
      forecast_info_destination = ForecastFacade.new(params[:destination]) #.forecast_for_given_location
      lat_long = forecast_info_destination.lat_long
      weather_for_destination = WeatherService.new.fetch_forecast_for_given_location(lat_long.latitude, lat_long.longitude)

      weather_for_destination_at_arrival = weather_for_destination[:forecast][:forecastday][days_to_arrive][:hour][hour_for_forecast]

      arrival_weather_info = {}

      arrival_weather_info[:datetime] = weather_for_destination_at_arrival[:time]
      arrival_weather_info[:temperature] = weather_for_destination_at_arrival[:temp_f]
      arrival_weather_info[:condition] = weather_for_destination_at_arrival[:condition][:text]
      arrival_weather_info
      
      
      road_trip = RoadTrip.new(params[:origin], params[:destination], travel_time, arrival_weather_info)
    end
    # require 'pry'; binding.pry
    render json: RoadTripSerializer.new(road_trip)


  end
end