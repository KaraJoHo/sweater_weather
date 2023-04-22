require "rails_helper"

RSpec.describe WeatherService do 
  before(:each) do 
    @service = WeatherService.new
  end

  describe "Exists" do 
    it "is a service" do 
      expect(@service).to be_a(WeatherService)
    end
  end

  describe "forecast calls", :vcr do 
    it "can get the forecast for a given location" do 
      weather_call = @service.fetch_forecast_for_given_location(39.74001, -104.99202)
      expect(weather_call).to be_a(Hash)
      expect(weather_call).to have_key(:location)
      expect(weather_call).to have_key(:current)
      expect(weather_call).to have_key(:forecast)
      expect(weather_call[:current]).to have_key(:temp_f)
      expect(weather_call[:current]).to have_key(:humidity)
      expect(weather_call[:current]).to have_key(:last_updated)
      expect(weather_call[:current]).to have_key(:uv)
      expect(weather_call[:forecast][:forecastday].count).to eq(5)
      expect(weather_call[:forecast][:forecastday].first[:hour].count).to eq(24)
    end
  end
end