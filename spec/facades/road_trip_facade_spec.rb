require "rails_helper"

RSpec.describe RoadTripFacade do 
  before(:each) do 
    @facade = RoadTripFacade.new("Denver,CO", "Boulder,CO")
  end

  describe "Exists" do 
    it "exists and has attributes" do 
      expect(@facade).to be_a(RoadTripFacade)
      expect(@facade.origin).to eq("Denver,CO")
      expect(@facade.destination).to eq("Boulder,CO")
      expect(@days_to_arrive).to eq(nil)
    end
  end

  describe "road trip methods", :vcr do 
    it "is a road trip" do 
      expect(@facade.road_trip).to be_a(RoadTrip)
      expect(@facade.road_trip.start_city).to eq("Denver,CO")
      expect(@facade.road_trip.travel_time).to be_a(String)
      expect(@facade.road_trip.end_city).to eq("Boulder,CO")
      expect(@facade.road_trip.weather_at_eta).to be_a(Hash)
      expect(@facade.days_to_arrive).to eq(0)
    end

    it "can get the forecast for the destination" do 
      expect(@facade.fetch_forecast_for_destination).to be_a(Hash)
    end

    it "can get the arrival time for a trip" do 
      expect(@facade.fetch_arrival_time("02:15:00")).to be_a(Time)
    end

    it "is the final hour of arrival" do 
      expect(@facade.hour_of_arrival(Time.now + 1.hours)).to be_an(Integer)
    end
  end
end