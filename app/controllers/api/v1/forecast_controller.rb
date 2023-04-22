class Api::V1::ForecastController < ApplicationController 
  def index 
    # map_conn = Faraday.new(url: "https://www.mapquestapi.com/geocoding/v1/address")

    # lat_long_response = map_conn.get("?key=#{ENV['MAPQUEST_KEY']}&location=#{params[:location]}")
    # parsed = JSON.parse(lat_long_response.body, symbolize_names: true)
 
    # lat_long = Geocode.new(parsed[:results][0][:locations][0][:latLng]) ### ORIGINAL
    # lat_long = ForecastFacade.new(params[:location]).geocode ### WITH FACADE

    #--------------------------------------------------------------- 

    # weather_conn = Faraday.new(url: "http://api.weatherapi.com")

    # weather_response = weather_conn.get("/v1/forecast.json?key=#{ENV['WEATHER_KEY']}&q=#{lat_long.latitude},#{lat_long.longitude}&days=5")

    # w_parsed = JSON.parse(weather_response.body, symbolize_names: true)
    
    # # current_weather = w_parsed[:current] #[:last_updated], [:temp_f], [:feelslike_f], [:humidity], [:uv], [:vis_miles], [:condition][:text], [:condition][:icon]
   
    # current = CurrentWeather.new(w_parsed[:current])
    
    # # daily_weather = w_parsed[:forecast][:forecastday] #[:date], [:astro][:sunrise], [:astro][:sunset], [:day][:maxtemp_f], [:day][:mintemp_f], [:day][:condition][:text], [:day][:condition][:icon] 
    # # require 'pry'; binding.pry
    # five_day_forecast = w_parsed[:forecast][:forecastday].map do |weather_info|
    #   DailyWeather.new(weather_info)
    # end

    # # hourly_weather = w_parsed[:forecast][:forecastday][0][:hour] #[:time] ("00:00"), [:temp_f], [:condition][:text], [:condition][:icon]
    # hourly_forecast = w_parsed[:forecast][:forecastday][0][:hour].map do |weather_info| 
    #   HourlyWeather.new(weather_info)
    # end

    # forecast = Forecast.new(current, five_day_forecast, hourly_forecast)
    
    # render json: ForecastSerializer.new(forecast)

    render json: ForecastSerializer.new(ForecastFacade.new(params[:location]).forecast_for_given_location)
  end
end