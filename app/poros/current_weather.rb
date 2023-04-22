class CurrentWeather 
    attr_reader :last_updated,
                :temperature,
                :feels_like,
                :humidity,
                :uvi,
                :visibility, 
                :condition, 
                :icon 

  def initialize(info)
    @last_updated = info[:last_updated]
    @temperature = info[:temp_f]
    @feels_like = info[:feelslike_f]
    @humidity = info[:humidity]
    @uvi = info[:uv]
    @visibility = info[:vis_miles]
    @condition = info[:condition][:text]
    @icon = info[:condition][:icon]
  end
end