class WeatherService 
  def fetch_forecast_for_given_location(lat, long)
    # weather_conn = Faraday.new(url: "http://api.weatherapi.com")

    # weather_response = weather_conn.get("/v1/forecast.json?key=#{ENV['WEATHER_KEY']}&q=#{lat},#{long}&days=5")

    # w_parsed = JSON.parse(weather_response.body, symbolize_names: true)
    get_url("/v1/forecast.json?key=#{ENV['WEATHER_KEY']}&q=#{lat},#{long}&days=5")
  end

  def conn 
    Faraday.new(url: "http://api.weatherapi.com")
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end
end