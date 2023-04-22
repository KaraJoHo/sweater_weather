class HourlyWeather 
  attr_reader :time,
              :temperature,
              :condition,
              :icon 

  def initialize(info)
    @time = info[:time].to_time.strftime("%H:%M")
    @temperature = info[:temp_f]
    @condition = info[:condition][:text]
    @icon = info[:condition][:icon]
  end

  def format_time 
    d = @date_time.to_time 
    d.strftime("%H:%M")
  end
end