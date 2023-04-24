require "rails_helper"

RSpec.describe Salaries do 
  before(:each) do 
    @salaries = Salaries.new("denver", {summary: "Nice", temperature: "54 F"}, [{title: "Job", min: "$20.00", max: "$50.00"}])
  end

  describe "exists" do 
    it "exists and has attributes" do 
      expect(@salaries).to be_a(Salaries)
      expect(@salaries.destination).to eq("denver")
      expect(@salaries.forecast).to be_a(Hash)
      expect(@salaries.forecast[:summary]).to eq("Nice")
      expect(@salaries.forecast[:temperature]).to eq("54 F")
      expect(@salaries.salaries).to be_an(Array)
      expect(@salaries.salaries.first[:title]).to eq("Job")
      expect(@salaries.salaries.first[:min]).to eq("$20.00")
      expect(@salaries.salaries.first[:max]).to eq("$50.00")
    end
  end
end