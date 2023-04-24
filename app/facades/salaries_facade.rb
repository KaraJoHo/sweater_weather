class SalariesFacade 
  attr_reader :destination
  
  def initialize(destination)
    @destination = destination
  end

  def salaries_for_destination 
    weather_for_destination = fetch_weather
    forecast = {"summary": weather_for_destination[:current][:condition][:text], "temperature": "#{weather_for_destination[:current][:temp_f].to_i} F"} 

    parsed = salaries_service.salaries_for_destination(@destination)

    wanted_job_titles = select_jobs(parsed)

    tech_salaries = create_salary_objects(wanted_job_titles)

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

  def salaries_service 
    @salaries_service ||= SalariesService.new
  end

  def select_jobs(salary_info_collection)
    tech_jobs = ["DATA-ANALYST", "DATA-SCIENTIST", "MOBILE-DEVELOPER", "QA-ENGINEER", "SOFTWARE-ENGINEER", "SYSTEMS-ADMINISTRATOR", "WEB-DEVELOPER"]
    wanted_list = salary_info_collection[:salaries].reject! do |job|
      !tech_jobs.include?(job[:job][:id])
    end
  end

  def create_salary_objects(job_titles)
    tech_salaries = job_titles.map do |job|
      SalaryInfo.new(job)
    end
  end
end