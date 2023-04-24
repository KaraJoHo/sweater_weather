require "rails_helper"

RSpec.describe SalaryInfo do 
  before(:each) do 
    attrs = {:job=>
              {:id=>"DATA-ANALYST", :title=>"Data Analyst"}, 
              :salary_percentiles=>
                {:percentile_25=>42878.34161807408, :percentile_50=>51604.570316663645, :percentile_75=>62106.68549841864}}
    @data_analyst = SalaryInfo.new(attrs)
  end

  describe "exists" do 
    it "exists and has attributes" do 
      expect(@data_analyst).to be_a(SalaryInfo)
      expect(@data_analyst.title).to eq("Data Analyst")
      expect(@data_analyst.min).to eq("$42,878.34")
      expect(@data_analyst.max).to eq("$62,106.57")
    end
  end
end