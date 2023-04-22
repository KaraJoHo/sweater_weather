require "rails_helper"

RSpec.describe Geocode do 
  before(:each) do 
    attrs = ({:lat=>39.74001, :lng=>-104.99202})
    @geocode = Geocode.new(attrs)
  end

  describe "Geocode exists" do 
    it "exists and has attributes" do 
      expect(@geocode).to be_a(Geocode)
      expect(@geocode.latitude).to eq(39.74001)
      expect(@geocode.longitude).to eq(-104.99202)
    end
  end
end