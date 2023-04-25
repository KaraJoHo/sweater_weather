 require "rails_helper"

 RSpec.describe ForecastFacade do 
  before(:each) do 
    @facade = ForecastFacade.new("denver,co")
  end

  describe "exists", :vcr do 
    it "exists and has attributes" do 
      expect(@facade).to be_a(ForecastFacade)
    end
  end

  describe "class methods", :vcr do 
    it "has latitude and longitude for a location" do 
      expect(@facade.lat_long).to be_a(Geocode)
    end

    it "has a forecast" do 
      expect(@facade.forecast_for_given_location).to be_a(Forecast)
      expect(@facade.forecast_for_given_location.current_weather).to be_a(CurrentWeather)
      expect(@facade.forecast_for_given_location.daily_weather.first).to be_a(DailyWeather)
      expect(@facade.forecast_for_given_location.daily_weather).to be_an(Array)
      expect(@facade.forecast_for_given_location.daily_weather.count).to eq(5)
      
      expect(@facade.forecast_for_given_location.hourly_weather.first).to be_a(HourlyWeather)
      expect(@facade.forecast_for_given_location.hourly_weather).to be_an(Array)
      expect(@facade.forecast_for_given_location.hourly_weather.count).to eq(24)
    end

    it "has a service" do 
      expect(@facade.weather_service).to be_a(WeatherService)
    end
  end
 end