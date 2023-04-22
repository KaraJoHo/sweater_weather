class ForecastFacade 
  def initialize(location)
    @location = location
  end

  def lat_long 
    # map_conn = Faraday.new(url: "https://www.mapquestapi.com/geocoding/v1/address")

    # lat_long_response = map_conn.get("?key=#{ENV['MAPQUEST_KEY']}&location=#{@location}")
    
    # parsed = JSON.parse(lat_long_response.body, symbolize_names: true)
   
    lat_long_hash = mapquest_service.lat_long(@location)[:results][0][:locations][0][:latLng]
   
    lat_long = Geocode.new(lat_long_hash) #Geocode.new(parsed[:results][0][:locations][0][:latLng])
  end

  def mapquest_service 
    @mapquest_service ||= MapquestService.new
  end

  def forecast_for_given_location 

    # weather_conn = Faraday.new(url: "http://api.weatherapi.com")

    # weather_response = weather_conn.get("/v1/forecast.json?key=#{ENV['WEATHER_KEY']}&q=#{lat_long.latitude},#{lat_long.longitude}&days=5")

    # w_parsed = JSON.parse(weather_response.body, symbolize_names: true)
    
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