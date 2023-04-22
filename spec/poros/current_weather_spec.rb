require "rails_helper"

RSpec.describe CurrentWeather do 
  before(:each) do 
    attrs = {
              :last_updated_epoch=>1682124300,
              :last_updated=>"2023-04-21 18:45",
              :temp_c=>6.1,
              :temp_f=>43.0,
              :condition=>{:text=>"Overcast", :icon=>"//cdn.weatherapi.com/weather/64x64/day/122.png", :code=>1009},
              :humidity=>30,
              :feelslike_c=>2.2,
              :feelslike_f=>35.9,
              :vis_km=>16.0,
              :vis_miles=>9.0,
              :uv=>3.0
            }
    @current = CurrentWeather.new(attrs)
  end

  describe "Current weather exists" do 
    it "exists and has attributes" do 
      expect(@current).to be_a(CurrentWeather)
      expect(@current.last_updated).to eq("2023-04-21 18:45")
      expect(@current.temperature).to eq(43.0)
      expect(@current.feels_like).to eq(35.9)
      expect(@current.humidity).to eq(30)
      expect(@current.uvi).to eq(3.0)
      expect(@current.visibility).to eq(9.0)
      expect(@current.condition).to eq("Overcast")
      expect(@current.icon).to eq("//cdn.weatherapi.com/weather/64x64/day/122.png")
    end
  end
end