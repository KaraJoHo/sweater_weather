class Api::V1::SalariesController < ApplicationController 
  def index 
    # params[:destination] -> "denver" | "destination": "denver"
    # you need, destination city, forecast, salary info

    forecast_info_destination = ForecastFacade.new(params[:destination]) 
    lat_long = forecast_info_destination.lat_long
    weather_for_destination = WeatherService.new.fetch_forecast_for_given_location(lat_long.latitude, lat_long.longitude)
    # weather_for_destination[:current][:temp_f] and weather_for_destination[:current][:condition][:text]
    forecast = {"summary": weather_for_destination[:current][:condition][:text], "temperature": "#{weather_for_destination[:current][:temp_f].to_i} F"} 
   

    conn = Faraday.new(url: "https://api.teleport.org")
    urban_city_response = conn.get("/api/urban_areas/slug:#{params[:destination]}/salaries")
    parsed =JSON.parse(urban_city_response.body, symbolize_names: true)

    tech_jobs = ["DATA-ANALYST", "DATA-SCIENTIST", "MOBILE-DEVELOPER", "QA-ENGINEER", "SOFTWARE-ENGINEER", "SYSTEMS-ADMINISTRATOR", "WEB-DEVELOPER"]
    # data_analyst = parsed[:salaries].select do |salary|
    #   salary[:job][:id] == "DATA-ANALYST"
    # end
    wanted_list = parsed[:salaries].reject! do |job|
      !tech_jobs.include?(job[:job][:id])
    end

    tech_salaries = wanted_list.map do |job|
      SalaryInfo.new(job)
    end

    salaries = tech_salaries.map do |salary|
      {"title": salary.title, "min": salary.min, "max": salary.max}
    end

    salary_info_for_destination = Salaries.new(params[:destination], forecast, salaries )

    render json: SalariesSerializer.new(salary_info_for_destination)

    # require 'pry'; binding.pry
  end
end