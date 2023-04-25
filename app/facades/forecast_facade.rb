class ForecastFacade 
  def initialize(location)
    @location = location
  end

  def lat_long 
    lat_long_hash = mapquest_service.lat_long(@location)[:results][0][:locations][0][:latLng]
   
    lat_long = Geocode.new(lat_long_hash) 
  end

  def mapquest_service 
    @mapquest_service ||= MapquestService.new
  end

  def forecast_for_given_location 

    all_weather_info = weather_service.fetch_forecast_for_given_location(lat_long.latitude, lat_long.longitude)

    current = CurrentWeather.new(all_weather_info[:current])
   
    five_day_forecast = all_weather_info[:forecast][:forecastday].map do |weather_info|
      DailyWeather.new(weather_info)
    end
    
    hourly_forecast = all_weather_info[:forecast][:forecastday][0][:hour].map do |weather_info| 
      HourlyWeather.new(weather_info)
    end

    forecast = Forecast.new(current, five_day_forecast, hourly_forecast)
  end

  def weather_service 
    @weather_service ||= WeatherService.new
  end
end