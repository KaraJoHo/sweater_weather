require "rails_helper"

RSpec.describe RoadTrip do 
  before(:each) do 
    @road_trip = RoadTrip.new("Denver, CO", "Boulder, CO", "01:15:00", {datetime: "2023-04-23 15:00", temperature: 50.0, condition: "Sunny"})
  end

  describe "Exists" do 
    it "exists and has attributes" do 
      expect(@road_trip).to be_a(RoadTrip)
      expect(@road_trip.start_city).to eq("Denver, CO")
      expect(@road_trip.end_city).to eq("Boulder, CO")
      expect(@road_trip.travel_time).to eq("01:15:00")
      expect(@road_trip.weather_at_eta).to be_a(Hash)
      expect(@road_trip.weather_at_eta.keys).to eq([:datetime, :temperature, :condition])
    end
  end
end