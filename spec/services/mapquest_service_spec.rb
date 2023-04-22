require "rails_helper"

RSpec.describe MapquestService do 
  before(:each) do 
    @service = MapquestService.new
  end

  describe "Exists" do 
    it "is a service" do 
      expect(@service).to be_a(MapquestService)
    end
  end

  describe "geocode methods", :vcr do 
    it "has a latitude and longitude api call" do 
      expect(@service.lat_long("denver,co")).to be_a(Hash)
      geo_call = @service.lat_long("denver,co")
     
      expect(geo_call[:results][0]).to have_key(:locations)
      expect(geo_call[:results][0][:locations][0]).to have_key(:latLng)
      expect(geo_call[:results][0][:locations][0][:latLng]).to be_a(Hash)
      expect(geo_call[:results][0][:locations][0][:latLng].keys).to eq([:lat, :lng])
    end
  end
end