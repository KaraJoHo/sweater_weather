require "rails_helper" 

RSpec.describe "Forecast Request for City" do 
  describe "Forecast request", :vcr do 
    it "can get the forecast for a given location" do 
      get "/api/v1/forecast?location=denver,co"

      expect(response).to be_successful

      forecast = JSON.parse(response.body, symbolize_names: true)
      # require 'pry'; binding.pry
      forecast_data_keys = [:id, :type, :attributes]
      forecast_attributes_keys = [:current_weather, :daily_weather, :hourly_weather]
      forecast_current_weather_keys = [:last_updated, :temperature, :feels_like, :humidity, :uvi, :visibility, :condition, :icon]
      forecast_hourly_weather_keys = [:time, :temperature, :condition, :icon]

      expect(forecast).to be_a(Hash)
      # expect(forecast).to have_key[:data]
      expect(forecast[:data]).to be_a(Hash)
      expect(forecast[:data].keys).to eq(forecast_data_keys)
      # expect(forecast[:data]).to have_key(:id)
      # expect(forecast[:data][:id]).to eq("null")
      # expect(forecast[:data]).to have_key(:type)
      expect(forecast[:data][:type]).to eq("forecast")
      # expect(forecast[:data]).to have_key(:attributes)

      expect(forecast[:data][:attributes]).to be_a(Hash)
      expect(forecast[:data][:attributes].keys).to eq(forecast_attributes_keys)

      # expect(forecast[:data][:attributes]).to have_key(:current_weather)
      expect(forecast[:data][:attributes][:current_weather]).to be_a(Hash)
      expect(forecast[:data][:attributes][:current_weather].keys).to eq(forecast_current_weather_keys)

      # expect(forecast[:data][:attributes][:current_weather]).to have_key(:last_updated)
      expect(forecast[:data][:attributes][:current_weather][:last_updated]).to be_a(String)
      # expect(forecast[:data][:attributes][:current_weather]).to have_key(:temperature)
      expect(forecast[:data][:attributes][:current_weather][:temperature]).to be_a(Float)
      expect(forecast[:data][:attributes][:current_weather][:feels_like]).to be_a(Float)
      expect(forecast[:data][:attributes][:current_weather][:humidity]).to be_an(Integer)
      expect(forecast[:data][:attributes][:current_weather][:uvi]).to be_a(Float)
      expect(forecast[:data][:attributes][:current_weather][:visibility]).to be_a(Float)
      expect(forecast[:data][:attributes][:current_weather][:condition]).to be_a(String)
      expect(forecast[:data][:attributes][:current_weather][:icon]).to be_a(String)
                
      
      expect(forecast[:data][:attributes][:daily_weather]).to be_an(Array)
      expect(forecast[:data][:attributes][:daily_weather].count).to eq(5)
      expect(forecast[:data][:attributes][:daily_weather].first).to be_a(Hash)
      expect(forecast[:data][:attributes][:daily_weather].first.keys).to eq([:date, :sunrise, :sunset, :max_temp, :min_temp, :condition, :icon])

      expect(forecast[:data][:attributes][:daily_weather].first[:date]).to be_a(String)
      expect(forecast[:data][:attributes][:daily_weather].first[:sunrise]).to be_a(String)
      expect(forecast[:data][:attributes][:daily_weather].first[:sunset]).to be_a(String)
      expect(forecast[:data][:attributes][:daily_weather].first[:max_temp]).to be_a(Float)
      expect(forecast[:data][:attributes][:daily_weather].first[:min_temp]).to be_a(Float)
      expect(forecast[:data][:attributes][:daily_weather].first[:condition]).to be_a(String)
      expect(forecast[:data][:attributes][:daily_weather].first[:icon]).to be_a(String)

      expect(forecast[:data][:attributes][:hourly_weather]).to be_an(Array)
      expect(forecast[:data][:attributes][:hourly_weather].first).to be_a(Hash)
      expect(forecast[:data][:attributes][:hourly_weather].first.keys).to eq(forecast_hourly_weather_keys)

      expect(forecast[:data][:attributes][:hourly_weather].first[:time]).to be_a(String)
      expect(forecast[:data][:attributes][:hourly_weather].first[:temperature]).to be_a(Float)
      expect(forecast[:data][:attributes][:hourly_weather].first[:condition]).to be_a(String)
      expect(forecast[:data][:attributes][:hourly_weather].first[:icon]).to be_a(String)
    end
  end
end