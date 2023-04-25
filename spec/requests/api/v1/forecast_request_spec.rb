require "rails_helper" 

RSpec.describe "Forecast Request for City" do 
  describe "Forecast request", :vcr do 
    it "can get the forecast for a given location" do 
      get "/api/v1/forecast?location=denver,co"

      expect(response).to be_successful

      forecast = JSON.parse(response.body, symbolize_names: true)
     
      forecast_data_keys = [:id, :type, :attributes]
      forecast_attributes_keys = [:current_weather, :daily_weather, :hourly_weather]
      forecast_current_weather_keys = [:last_updated, :temperature, :feels_like, :humidity, :uvi, :visibility, :condition, :icon]
      forecast_daily_weather_keys = [:date, :sunrise, :sunset, :max_temp, :min_temp, :condition, :icon]
      forecast_hourly_weather_keys = [:time, :temperature, :condition, :icon]

      expect(forecast).to be_a(Hash)
      expect(forecast).to have_key(:data)
      expect(forecast[:data]).to be_a(Hash)
      expect(forecast[:data].keys).to eq(forecast_data_keys)
      expect(forecast[:data][:id]).to eq(nil)
      expect(forecast[:data][:type]).to be_a(String)
      expect(forecast[:data][:type]).to eq("forecast")

      expect(forecast[:data][:attributes]).to be_a(Hash)
      expect(forecast[:data][:attributes].keys).to eq(forecast_attributes_keys)

      expect(forecast[:data][:attributes][:current_weather]).to be_a(Hash)
      expect(forecast[:data][:attributes][:current_weather].keys).to eq(forecast_current_weather_keys)

      expect(forecast[:data][:attributes][:current_weather][:last_updated]).to be_a(String)
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
      expect(forecast[:data][:attributes][:daily_weather].first.keys).to eq(forecast_daily_weather_keys)

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

    it "renders an error if no location was passed" do 
      get "/api/v1/forecast?location="

      expect(response).to_not be_successful
      expect(response.status).to eq(400)

      error = JSON.parse(response.body, symbolize_names: true)

      expect(error[:errors]).to eq(["No location provided"])
    end

    it "should only have specific keys in the response" do 
      get "/api/v1/forecast?location=denver,co"

      expect(response).to be_successful

      forecast = JSON.parse(response.body, symbolize_names: true)
      
     
      forecast_data_keys = [:id, :type, :attributes]
      forecast_attributes_keys = [:current_weather, :daily_weather, :hourly_weather]
      forecast_current_weather_keys = [:last_updated, :temperature, :feels_like, :humidity, :uvi, :visibility, :condition, :icon]
      forecast_daily_weather_keys = [:date, :sunrise, :sunset, :max_temp, :min_temp, :condition, :icon]
      forecast_hourly_weather_keys = [:time, :temperature, :condition, :icon]

      current_weather_keys_not_included = ([:last_updated_epoch, :temp_c, :is_day, 
                                            :wind_mph, :wind_kph, :wind_degree, :wind_dir, 
                                            :pressure_in, :precip_mm, :precip_in, :cloud, 
                                            :feelslike_c, :feelslike_f, :vis_km, :vis_miles,
                                            :gust_mph, :gust_kph])
      daily_weather_keys_not_included = ([:maxtemp_c, :mintemp_c, :avgtemp_c, 
                                          :maxwind_mph, :maxwind_kph, :totalprecip_mm,
                                          :totalprecip_in, :totalsnow_cm, :avgvis_km,
                                          :avghumidity, :daily_will_it_rain, :daily_chance_of_rain,
                                          :daily_will_it_snow, :daily_chance_of_snow, :uv,
                                          :astro, :hour=])
      hourly_weather_keys_not_included = ([:time_epoch, :temp_c, :is_day,
                                          :wind_mph, :wind_kph, :wind_degree, :wind_dir,
                                          :pressure_mb, :pressure_in, :precip_mm, :precip_in,
                                          :humidity, :cloud, :feelslike_c, :feelslike_f,
                                          :windchill_c, :windchill_f, :heatindex_c, :heatindex_f,
                                          :dewpoint_c, :dewpoint_f, :will_it_rain, :chance_of_rain,
                                          :will_it_snow, :chance_of_snow, :vis_km, :vis_miles,
                                          :gust_mph, :gust_kph, :uv])

      expect(forecast).to have_key(:data)
      expect(forecast[:data].keys).to eq(forecast_data_keys)
      expect(forecast[:data][:attributes].keys).to eq(forecast_attributes_keys)
      expect(forecast[:data][:attributes][:current_weather].keys).to eq(forecast_current_weather_keys)
      expect(forecast[:data][:attributes][:daily_weather].first.keys).to eq(forecast_daily_weather_keys)
      expect(forecast[:data][:attributes][:hourly_weather].first.keys).to eq(forecast_hourly_weather_keys)
      
      expect(forecast[:data][:attributes][:current_weather].keys).to_not include(current_weather_keys_not_included)
      expect(forecast[:data][:attributes][:daily_weather].first.keys).to_not include(daily_weather_keys_not_included)
      expect(forecast[:data][:attributes][:hourly_weather].first.keys).to_not include(hourly_weather_keys_not_included)
    end
  end
end