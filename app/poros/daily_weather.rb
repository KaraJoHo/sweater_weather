class DailyWeather 
  attr_reader :date,
              :sunrise, 
              :sunset, 
              :max_temp, 
              :min_temp, 
              :condition, 
              :icon
              
  def initialize(info)
    @date = info[:date]
    @sunrise = info[:astro][:sunrise]
    @sunset = info[:astro][:sunset]
    @max_temp = info[:day][:maxtemp_f]
    @min_temp = info[:day][:mintemp_f]
    @condition = info[:day][:condition][:text]
    @icon = info[:day][:condition][:icon]
  end
end