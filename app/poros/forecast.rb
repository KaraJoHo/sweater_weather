class Forecast 
  attr_reader :current_weather,
              :daily_weather, 
              :hourly_weather,
              :id
  def initialize(current, daily, hourly)
    @id = nil
    @current_weather = current 
    @daily_weather = daily 
    @hourly_weather = hourly
  end
end