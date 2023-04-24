require "rails_helper"

RSpec.describe "Salaries Request" do 
  describe "Get salaries for a destination", :vcr do 
    it "is a list of tech salaries for a given destination, along with the current forecast" do
      get "/api/v1/salaries?destination=denver"

      expect(response).to be_successful 

      salary_info = JSON.parse(response.body, symbolize_names: true)

      expect(salary_info).to be_a(Hash)
      expect(salary_info).to have_key(:data)
      expect(salary_info[:data].keys).to eq([:id, :type, :attributes])
      expect(salary_info[:data][:id]).to eq(nil)
      expect(salary_info[:data][:type]).to eq("salaries")
      expect(salary_info[:data][:attributes]).to be_a(Hash)
      expect(salary_info[:data][:attributes].keys).to eq([:destination, :forecast, :salaries])
      expect(salary_info[:data][:attributes][:destination]).to be_a(String)
      expect(salary_info[:data][:attributes][:destination]).to eq("denver")
      expect(salary_info[:data][:attributes][:forecast]).to be_a(Hash)
      expect(salary_info[:data][:attributes][:forecast].keys).to eq([:summary, :temperature])
      expect(salary_info[:data][:attributes][:forecast][:summary]).to be_a(String)
      expect(salary_info[:data][:attributes][:forecast][:temperature]).to be_a(String)
      expect(salary_info[:data][:attributes][:salaries]).to be_an(Array)
      expect(salary_info[:data][:attributes][:salaries].first).to be_a(Hash)
      expect(salary_info[:data][:attributes][:salaries].first[:title]).to be_a(String)
      expect(salary_info[:data][:attributes][:salaries].first[:min]).to be_a(String)
      expect(salary_info[:data][:attributes][:salaries].first[:max]).to be_a(String)
    end

    it "can get another destinations salary information" do 
      get "/api/v1/salaries?destination=austin"

      expect(response).to be_successful 

      salary_info = JSON.parse(response.body, symbolize_names: true)

      expect(salary_info).to be_a(Hash)
      expect(salary_info).to have_key(:data)
      expect(salary_info[:data].keys).to eq([:id, :type, :attributes])
      expect(salary_info[:data][:id]).to eq(nil)
      expect(salary_info[:data][:type]).to eq("salaries")
      expect(salary_info[:data][:attributes]).to be_a(Hash)
      expect(salary_info[:data][:attributes].keys).to eq([:destination, :forecast, :salaries])
      expect(salary_info[:data][:attributes][:destination]).to eq("austin")
      expect(salary_info[:data][:attributes][:forecast]).to be_a(Hash)
      expect(salary_info[:data][:attributes][:forecast].keys).to eq([:summary, :temperature])
      expect(salary_info[:data][:attributes][:forecast][:summary]).to be_a(String)
      expect(salary_info[:data][:attributes][:forecast][:temperature]).to be_a(String)
      expect(salary_info[:data][:attributes][:salaries]).to be_an(Array)
      expect(salary_info[:data][:attributes][:salaries].first).to be_a(Hash)
      expect(salary_info[:data][:attributes][:salaries].first[:title]).to be_a(String)
      expect(salary_info[:data][:attributes][:salaries].first[:min]).to be_a(String)
      expect(salary_info[:data][:attributes][:salaries].first[:max]).to be_a(String)
    end
  end
end