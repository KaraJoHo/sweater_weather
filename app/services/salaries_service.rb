class SalariesService 
  def salaries_for_destination(destination)
    get_url("/api/urban_areas/slug:#{destination}/salaries")
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn 
    Faraday.new(url: "https://api.teleport.org")
  end
end