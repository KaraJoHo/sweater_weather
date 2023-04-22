class Geocode 
  attr_reader :latitude, :longitude 

  def initialize(lat_long)
    @latitude = lat_long[:lat]
    @longitude = lat_long[:lng]
  end
end