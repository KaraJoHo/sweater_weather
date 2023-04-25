require "rails_helper"

RSpec.describe "Road Trip Request" do 
  describe "Creating a road trip", :vcr do 
    it "has road trip duration and weather at destination for multiday trip" do 
      user = User.create!(email: "user@email.com", password: "passed", api_key: "t1h2i3s4_i5s6_l7e8g9i10t11")
      request_body = {
                      "origin": "New York, NY",
                      "destination": "Los Angeles, CA",
                      "api_key": "t1h2i3s4_i5s6_l7e8g9i10t11"
                    }
      headers = {"CONTENT_TYPE" => "application/json", "Accept" => "application/json"}
      post "/api/v1/road_trip", headers: headers, params: JSON.generate(request_body)

      expect(response).to be_successful

      road_trip = JSON.parse(response.body, symbolize_names: true)

      expect(road_trip).to be_a(Hash)
      expect(road_trip).to have_key(:data)
      expect(road_trip[:data].keys).to eq([:id, :type, :attributes])
      expect(road_trip[:data][:attributes]).to be_a(Hash)
      expect(road_trip[:data][:attributes].keys).to eq([:start_city, :end_city, :travel_time, :weather_at_eta])
      expect(road_trip[:data][:attributes][:weather_at_eta]).to be_a(Hash)
      expect(road_trip[:data][:attributes][:weather_at_eta].keys).to eq([:datetime, :temperature, :condition])   
      expect(road_trip[:data][:type]).to eq("road_trip")

      expect(road_trip[:data][:attributes][:start_city]).to be_a(String)
      expect(road_trip[:data][:attributes][:end_city]).to be_a(String)
      expect(road_trip[:data][:attributes][:travel_time]).to be_a(String)
      expect(road_trip[:data][:attributes][:weather_at_eta][:datetime]).to be_a(String)
      expect(road_trip[:data][:attributes][:weather_at_eta][:temperature]).to be_a(Float)
      expect(road_trip[:data][:attributes][:weather_at_eta][:condition]).to be_a(String)
    end

    it "has road trip duration and weather at destination for a less than 24 hour trip" do
      user = User.create!(email: "user@email.com", password: "passed", api_key: "t1h2i3s4_i5s6_l7e8g9i10t11")
      request_body = {
                      "origin": "Cincinatti,OH",
                      "destination": "Chicago,IL",
                      "api_key": "t1h2i3s4_i5s6_l7e8g9i10t11"
                    }
      headers = {"CONTENT_TYPE" => "application/json", "Accept" => "application/json"}
      post "/api/v1/road_trip", headers: headers, params: JSON.generate(request_body)

      expect(response).to be_successful

      road_trip = JSON.parse(response.body, symbolize_names: true)

      expect(road_trip).to be_a(Hash)
      expect(road_trip).to have_key(:data)
      expect(road_trip[:data].keys).to eq([:id, :type, :attributes])
      expect(road_trip[:data][:attributes]).to be_a(Hash)
      expect(road_trip[:data][:attributes].keys).to eq([:start_city, :end_city, :travel_time, :weather_at_eta])
      expect(road_trip[:data][:attributes][:weather_at_eta]).to be_a(Hash)
      expect(road_trip[:data][:attributes][:weather_at_eta].keys).to eq([:datetime, :temperature, :condition])   
      expect(road_trip[:data][:type]).to eq("road_trip")

      expect(road_trip[:data][:attributes][:start_city]).to be_a(String)
      expect(road_trip[:data][:attributes][:end_city]).to be_a(String)
      expect(road_trip[:data][:attributes][:travel_time]).to be_a(String)
      expect(road_trip[:data][:attributes][:weather_at_eta][:datetime]).to be_a(String)
      expect(road_trip[:data][:attributes][:weather_at_eta][:temperature]).to be_a(Float)
      expect(road_trip[:data][:attributes][:weather_at_eta][:condition]).to be_a(String)
    end

    it "does not have weather info for an impossible road trip" do 
      user = User.create!(email: "user@email.com", password: "passed", api_key: "t1h2i3s4_i5s6_l7e8g9i10t11")
      request_body = {
                      "origin": "Cincinatti,OH",
                      "destination": "London, UK",
                      "api_key": "t1h2i3s4_i5s6_l7e8g9i10t11"
                    }
      headers = {"CONTENT_TYPE" => "application/json", "Accept" => "application/json"}
      post "/api/v1/road_trip", headers: headers, params: JSON.generate(request_body)

      expect(response).to be_successful

      road_trip = JSON.parse(response.body, symbolize_names: true)

      expect(road_trip[:data][:attributes][:travel_time]).to eq("impossible")
      expect(road_trip[:data][:attributes][:weather_at_eta]).to eq({})
    end

    it "renders an error if no api key is given" do 
      user = User.create!(email: "user@email.com", password: "passed", api_key: "123")
      request_body = {
                      "origin": "Cincinatti,OH",
                      "destination": "Denver,CO"
                    }
      headers = {"CONTENT_TYPE" => "application/json", "Accept" => "application/json"}
      post "/api/v1/road_trip", headers: headers, params: JSON.generate(request_body)

      expect(response).to_not be_successful
      expect(response.status).to eq(401)

      error = JSON.parse(response.body, symbolize_names: true)

      expect(error[:errors]).to eq(["Key is incorrect or not present"])
    end

    it "renders an error message if the api key is incorrect" do 
      user = User.create!(email: "user@email.com", password: "passed", api_key: "123")
      user = User.create!(email: "userrr@email.com", password: "passed", api_key: "777")
      request_body = {
                      "origin": "Cincinatti,OH",
                      "destination": "Denver,CO",
                      "api_key": "456"
                    }
      headers = {"CONTENT_TYPE" => "application/json", "Accept" => "application/json"}
      post "/api/v1/road_trip", headers: headers, params: JSON.generate(request_body)

      expect(response).to_not be_successful
      expect(response.status).to eq(401)

      error = JSON.parse(response.body, symbolize_names: true)

      expect(error[:errors]).to eq(["Key is incorrect or not present"])
    end

    it "renders an error if destination is not provided" do 
      user = User.create!(email: "user@email.com", password: "passed", api_key: "t1h2i3s4_i5s6_l7e8g9i10t11")
      request_body = {
                      "origin": "Cincinatti,OH",
                      "api_key": "t1h2i3s4_i5s6_l7e8g9i10t11"
                    }
      headers = {"CONTENT_TYPE" => "application/json", "Accept" => "application/json"}
      post "/api/v1/road_trip", headers: headers, params: JSON.generate(request_body)

      expect(response).to_not be_successful
      expect(response.status).to eq(400)

      error = JSON.parse(response.body, symbolize_names: true)

      expect(error[:errors]).to eq(["Origin and/or destination was not provided"])
    end

    it "renders an error if origin is not provided" do 
      user = User.create!(email: "user@email.com", password: "passed", api_key: "t1h2i3s4_i5s6_l7e8g9i10t11")
      request_body = {
                      "destination": "Cincinatti,OH",
                      "api_key": "t1h2i3s4_i5s6_l7e8g9i10t11"
                    }
      headers = {"CONTENT_TYPE" => "application/json", "Accept" => "application/json"}
      post "/api/v1/road_trip", headers: headers, params: JSON.generate(request_body)

      expect(response).to_not be_successful
      expect(response.status).to eq(400)

      error = JSON.parse(response.body, symbolize_names: true)

      expect(error[:errors]).to eq(["Origin and/or destination was not provided"])
    end

    it "renders an error if neither origin or destination is provided" do 
      user = User.create!(email: "user@email.com", password: "passed", api_key: "t1h2i3s4_i5s6_l7e8g9i10t11")
      request_body = {
                      "api_key": "t1h2i3s4_i5s6_l7e8g9i10t11"
                    }
      headers = {"CONTENT_TYPE" => "application/json", "Accept" => "application/json"}
      post "/api/v1/road_trip", headers: headers, params: JSON.generate(request_body)

      expect(response).to_not be_successful
      expect(response.status).to eq(400)

      error = JSON.parse(response.body, symbolize_names: true)

      expect(error[:errors]).to eq(["Origin and/or destination was not provided"])
    end
  end
end