class RoadTripFacade 
  attr_reader :origin, :destination, :days_to_arrive

  def initialize(origin, destination)
    @origin = origin 
    @destination = destination
    @days_to_arrive = nil
  end

  def road_trip 
    trip = mapquest_service.trip(@origin, @destination)
   
    if trip[:info][:statuscode] == 402
      travel_time = "impossible"
      weather_info_hash = {}
      road_trip = RoadTrip.new(@origin, @destination, travel_time, weather_info_hash)
    else
   
      travel_time = trip[:route][:formattedTime] 

      time_at_arrival = fetch_arrival_time(travel_time)
      hour_for_forecast = hour_of_arrival(time_at_arrival)

      weather_for_destination_at_arrival = fetch_forecast_for_destination[:forecast][:forecastday][@days_to_arrive][:hour][hour_for_forecast]

      arrival_weather_info = weather_information(weather_for_destination_at_arrival)
      
      road_trip = RoadTrip.new(@origin, @destination, travel_time, arrival_weather_info)
    end
  end

  def mapquest_service 
    @mapquest_service ||= MapquestService.new
  end

  def fetch_arrival_time(travel_time)
    
    duration_hours = travel_time[0..1].to_i 
    duration_minutes = travel_time[3..4].to_i 
    duration_seconds = travel_time[6..7].to_i 
      
    @days_to_arrive = (duration_hours / 24) 
    hours_after_multiday_trip = (duration_hours - (@days_to_arrive * 24)) 

    if @days_to_arrive == 0
      Time.now + duration_hours.hours + duration_minutes.minutes + duration_seconds.seconds
    else 
      Time.now + hours_after_multiday_trip.hours + duration_minutes.minutes + duration_seconds.seconds
    end
  end

  def hour_of_arrival(time_at_arrival)
    hour_at_arrival = time_at_arrival.strftime("%H:%M")
    hour_at_arrival[0..1].to_i
  end

  def fetch_forecast_for_destination 
    forecast_info_destination = ForecastFacade.new(@destination) 
    lat_long = forecast_info_destination.lat_long
    weather_for_destination = WeatherService.new.fetch_forecast_for_given_location(lat_long.latitude, lat_long.longitude)
  end

  def weather_information(weather)
    arrival_weather_info = {}

    arrival_weather_info[:datetime] = weather[:time]
    arrival_weather_info[:temperature] = weather[:temp_f]
    arrival_weather_info[:condition] = weather[:condition][:text]
    arrival_weather_info  
  end
end