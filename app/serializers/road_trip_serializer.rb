class RoadTripSerializer 
  include JSONAPI::Serializer 
  set_id{nil}
  attributes :start_city, :end_city, :travel_time, :weather_at_eta
end