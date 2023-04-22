require "rails_helper"

RSpec.describe Forecast do 
  before(:each) do 
    c_attrs = attrs = { :last_updated=>"2023-04-21 18:45", :temp_f=>43.0, :condition=>{:text=>"Hi"}}
    d_attrs =  attrs = {:date=>"2023-04-21", :day=>{:maxtemp_f=>54.3, :condition=>{:text=>"Hi"}}, :astro=>{:sunrise=>"06:14 AM", :sunset=>"07:44 PM"}}
    h_attrs = attrs = {:time=>"2023-04-21 00:00", :temp_f=>38.5, :condition=>{:text=>"Hi"}}
    d = []
    h = []

    current = CurrentWeather.new(c_attrs)

    daily_1 = DailyWeather.new(d_attrs)
    daily_2 = DailyWeather.new(d_attrs)
    d << daily_1 
    d << daily_2

    hourly_1 = HourlyWeather.new(h_attrs)
    hourly_2 = HourlyWeather.new(h_attrs)
    h << hourly_1
    h << hourly_2

    @forecast = Forecast.new(current, d, h)
  end
  describe "Forecast exists" do 
    it "exists and has attributes" do 
      expect(@forecast).to be_a(Forecast)
      expect(@forecast.id).to eq(nil)
      expect(@forecast.current_weather).to be_a(CurrentWeather)
      expect(@forecast.daily_weather).to be_an(Array)
      expect(@forecast.daily_weather.first).to be_a(DailyWeather)
      expect(@forecast.hourly_weather).to be_an(Array)
      expect(@forecast.hourly_weather.first).to be_a(HourlyWeather)
    end
  end
end