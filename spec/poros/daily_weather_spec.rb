require "rails_helper"

RSpec.describe DailyWeather do 
  before(:each) do 
    attrs = {
            :date=>"2023-04-21",
            :day=>
            {:maxtemp_c=>12.4,
              :maxtemp_f=>54.3,
              :mintemp_c=>1.2,
              :mintemp_f=>34.2,
              :condition=>{:text=>"Patchy rain possible", :icon=>"//cdn.weatherapi.com/weather/64x64/day/176.png"},
              :uv=>2.0},
            :astro=>{:sunrise=>"06:14 AM", :sunset=>"07:44 PM"}
          }
    @daily = DailyWeather.new(attrs)
  end

  describe "DailyWeather exists" do 
    it "exists and has attributes" do 
      expect(@daily).to be_a(DailyWeather)
      expect(@daily.date).to eq("2023-04-21")
      expect(@daily.sunrise).to eq("06:14 AM")
      expect(@daily.sunset).to eq("07:44 PM")
      expect(@daily.max_temp).to eq(54.3)
      expect(@daily.min_temp).to eq(34.2)
      expect(@daily.condition).to eq("Patchy rain possible")
      expect(@daily.icon).to eq("//cdn.weatherapi.com/weather/64x64/day/176.png")
    end
  end
end