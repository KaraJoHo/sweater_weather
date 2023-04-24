class SalariesFacade 
  attr_reader :destination
  def initialize(destination)
    @destination = destination
  end

  def salaries_for_destination 
    # forecast_info_destination = ForecastFacade.new(@destination) 
    # lat_long = forecast_info_destination.lat_long
    # weather_for_destination = WeatherService.new.fetch_forecast_for_given_location(lat_long.latitude, lat_long.longitude)
    weather_for_destination = fetch_weather
    forecast = {"summary": weather_for_destination[:current][:condition][:text], "temperature": "#{weather_for_destination[:current][:temp_f].to_i} F"} 
   

    conn = Faraday.new(url: "https://api.teleport.org")
    urban_city_response = conn.get("/api/urban_areas/slug:#{@destination}/salaries")
    parsed =JSON.parse(urban_city_response.body, symbolize_names: true)

    tech_jobs = ["DATA-ANALYST", "DATA-SCIENTIST", "MOBILE-DEVELOPER", "QA-ENGINEER", "SOFTWARE-ENGINEER", "SYSTEMS-ADMINISTRATOR", "WEB-DEVELOPER"]
   
    wanted_list = parsed[:salaries].reject! do |job|
      !tech_jobs.include?(job[:job][:id])
    end

    tech_salaries = wanted_list.map do |job|
      SalaryInfo.new(job)
    end

    salaries = tech_salaries.map do |salary|
      {"title": salary.title, "min": salary.min, "max": salary.max}
    end

    salary_info_for_destination = Salaries.new(@destination, forecast, salaries)
  end

  def fetch_weather 
    forecast_info_destination = ForecastFacade.new(@destination) 
    lat_long = forecast_info_destination.lat_long
    WeatherService.new.fetch_forecast_for_given_location(lat_long.latitude, lat_long.longitude)
  end
end