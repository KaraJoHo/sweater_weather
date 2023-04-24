require "rails_helper"

RSpec.describe SalariesFacade do 
  before(:each) do 
    @facade = SalariesFacade.new("denver")
  end

  describe "exists" do 
    it "exists and has a destination" do 
      expect(@facade).to be_a(SalariesFacade)
      expect(@facade.destination).to eq("denver")
    end
  end

  describe "methods" do 
    it "can get salary info for a destination", :vcr do 
      expect(@facade.salaries_for_destination).to be_a(Salaries)
      salary_info = @facade.salaries_for_destination
      expect(salary_info.forecast).to be_a(Hash)
      expect(salary_info.destination).to eq("denver")
      expect(salary_info.salaries).to be_an(Array)
      expect(salary_info.salaries.first).to be_a(Hash)
      expect(salary_info.salaries.first[:title]).to be_a(String)
      expect(salary_info.salaries.first[:min]).to be_a(String)
      expect(salary_info.salaries.first[:max]).to be_a(String)
      expect(salary_info.forecast[:summary]).to be_a(String)
      expect(salary_info.forecast[:temperature]).to be_a(String)
    end

    it "can get weather forecast for a destination", :vcr do 
      expect(@facade.fetch_weather).to be_a(Hash)
      forecast = @facade.fetch_weather 
      expect(forecast[:current]).to have_key(:condition)
      expect(forecast[:current][:condition]).to have_key(:text)
      expect(forecast[:current][:condition][:text]).to be_a(String)
      expect(forecast[:current]).to have_key(:temp_f)
      expect(forecast[:current][:temp_f]).to be_a(Float)
    end
  end
end