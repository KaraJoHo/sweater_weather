class MapquestService

  def lat_long(location)
    # map_conn = Faraday.new(url: "https://www.mapquestapi.com/geocoding/v1/address")

    # lat_long_response = geo_conn.get("?key=#{ENV['MAPQUEST_KEY']}&location=#{location}")
    # parsed = JSON.parse(lat_long_response.body, symbolize_names: true)
    geo_get_url("?key=#{ENV['MAPQUEST_KEY']}&location=#{location}")
  end

  def geo_conn 
    Faraday.new(url: "https://www.mapquestapi.com/geocoding/v1/address")
  end

  def geo_get_url(url)
    response = geo_conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end
end