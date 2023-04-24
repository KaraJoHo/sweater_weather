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
      expect(@salaries.salaries).to be_an(Array)
    end
  end
end