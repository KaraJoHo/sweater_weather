class RoadTrip 
  attr_reader :start_city, :end_city, :travel_time, :weather_at_eta
  def initialize(start_city, end_city, travel_time, arrival_weather_info)
    @start_city = start_city 
    @end_city = end_city
    @travel_time = travel_time 
    @weather_at_eta = arrival_weather_info
  end
end