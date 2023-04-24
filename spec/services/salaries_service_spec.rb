require "rails_helper"

RSpec.describe SalariesService do 
  before(:each) do 
    @service = SalariesService.new
  end

  describe "exists" do 
    it "is a service" do 
      expect(@service).to be_a(SalariesService)
    end
  end

  describe "methods", :vcr do 
    it "can get salaries for a destination", :vcr do 
      expect(@service.salaries_for_destination("denver")).to be_a(Hash)
      salaries = @service.salaries_for_destination("denver")
      expect(salaries[:salaries]).to be_an(Array)
      expect(salaries[:salaries].first).to be_a(Hash)
      expect(salaries[:salaries].first.keys).to eq([:job, :salary_percentiles])
      expect(salaries[:salaries].first[:job]).to be_a(Hash)
      expect(salaries[:salaries].first[:job].keys).to eq([:id, :title])
      expect(salaries[:salaries].first[:job][:id]).to be_a(String)
      expect(salaries[:salaries].first[:job][:title]).to be_a(String)
      expect(salaries[:salaries].first[:salary_percentiles]).to be_a(Hash)
      expect(salaries[:salaries].first[:salary_percentiles].keys).to eq([:percentile_25, :percentile_50, :percentile_75])
      expect(salaries[:salaries].first[:salary_percentiles][:percentile_25]).to be_a(Float)
      expect(salaries[:salaries].first[:salary_percentiles][:percentile_50]).to be_a(Float)
      expect(salaries[:salaries].first[:salary_percentiles][:percentile_75]).to be_a(Float)
    
    end

    it "is a faraday connection" do 
      expect(@service.conn).to be_a(Faraday::Connection)
    end
  end
end