class MapquestService

  def lat_long(location)
    get_url("/geocoding/v1/address?key=#{ENV['MAPQUEST_KEY']}&location=#{location}")
  end

  def trip(origin, destination)
    get_url("/directions/v2/route?key=#{ENV["MAPQUEST_KEY"]}&from=#{origin}&to=#{destination}")
  end

  def conn 
    Faraday.new(url: "https://www.mapquestapi.com")
  end

  def get_url(url) 
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end
end