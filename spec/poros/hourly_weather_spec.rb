require "rails_helper"

RSpec.describe HourlyWeather do 
  before(:each) do 
    attrs = {
            :time=>"2023-04-21 00:00",
            :temp_c=>3.6,
            :temp_f=>38.5,
            :condition=>{:text=>"Clear", :icon=>"//cdn.weatherapi.com/weather/64x64/night/113.png"}
          }
    @hourly = HourlyWeather.new(attrs)
  end

  describe "Hourly Weather exists" do 
    it "exists and has attributes" do 
      expect(@hourly).to be_a(HourlyWeather)
      expect(@hourly.time).to eq("00:00")
      expect(@hourly.temperature).to eq(38.5)
      expect(@hourly.condition).to eq("Clear")
      expect(@hourly.icon).to eq("//cdn.weatherapi.com/weather/64x64/night/113.png")
    end
  end
end