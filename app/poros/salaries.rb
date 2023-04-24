class Salaries 
  attr_reader :destination, :forecast, :salaries
  def initialize(destination, forecast, salaries)
    @destination = destination
    @forecast = forecast 
    @salaries = salaries
  end
end