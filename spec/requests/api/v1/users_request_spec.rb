require "rails_helper"

RSpec.describe "Users" do 
  describe "registration" do 
    it "can register a user and generate an api key with a 201 status" do 
      request_body = {
                      "email": "whatever@example.com",
                      "password": "password",
                      "password_confirmation": "password"
                    }
      headers = {"CONTENT_TYPE" => "application/json"}
      post "/api/v1/users", headers: headers, params: JSON.generate(request_body)
      
      expect(response).to be_successful 
      expect(response.status).to eq(201)

      user_response = JSON.parse(response.body, symbolize_names: true)
      
      expect(user_response).to be_a(Hash)
      expect(user_response).to have_key(:data)
      expect(user_response[:data]).to have_key(:attributes)
      expect(user_response[:data]).to have_key(:id)
      expect(user_response[:data][:attributes]).to have_key(:api_key)
      expect(user_response[:data][:attributes]).to have_key(:email)
      expect(user_response[:data][:attributes]).to_not have_key(:password)
      
      created_user = User.last 
      expect(created_user.email).to eq(request_body[:email])
    end

    it "raises an error when the passowrds dont match" do 
      request_body = {
                      "email": "whatever@example.com",
                      "password": "password",
                      "password_confirmation": "passwhoops"
                    }
      headers = {"CONTENT_TYPE" => "application/json"}
      post "/api/v1/users", headers: headers, params: JSON.generate(request_body)
      
      expect(response).to_not be_successful 
      expect(response.status).to eq(404)

      error_response = JSON.parse(response.body, symbolize_names: true)
               
      expect(error_response).to be_a(Hash)
      expect(error_response.keys).to eq([:title, :errors])
      expect(error_response[:errors]).to be_an(Array)
      expect(error_response[:errors]).to eq(["Validation failed: Password confirmation doesn't match Password, Password confirmation doesn't match Password"])
    end

    it "will raise an error is an email already exists" do 
      user = User.create!(email: "whatever@example.com", password: "pass", password_confirmation: "pass")
      
      request_body = {
                      "email": "whatever@example.com",
                      "password": "password",
                      "password_confirmation": "password"
                    }
      headers = {"CONTENT_TYPE" => "application/json"}
      post "/api/v1/users", headers: headers, params: JSON.generate(request_body)
      
      expect(response).to_not be_successful 
      expect(response.status).to eq(404)

      error_response = JSON.parse(response.body, symbolize_names: true)

      expect(error_response).to be_a(Hash)
      expect(error_response[:errors]).to eq(["Validation failed: Email has already been taken"]) 
    end

    it "raises an error if a field is missing" do 
      request_body = {
                      "password": "password",
                      "password_confirmation": "password"
                    }
      headers = {"CONTENT_TYPE" => "application/json"}
      post "/api/v1/users", headers: headers, params: JSON.generate(request_body)
      
      expect(response).to_not be_successful 
      expect(response.status).to eq(404)
      error_response = JSON.parse(response.body, symbolize_names: true)
      expect(error_response[:errors]).to eq(["Validation failed: Email can't be blank"])
    end
  end

  describe "sessions" do 
    it "can log a user in/create a session" do 
      user = User.create!(email: "whatever@example.com", password: "password1", password_confirmation: "password1")
      
      request_body = {email: "whatever@example.com", password: "password1"}
      headers = {"CONTENT_TYPE" => "application/json", "Accept" => "application/json"}

      post "/api/v1/sessions", headers: headers, params: JSON.generate(request_body)

      expect(response).to be_successful

      session = JSON.parse(response.body, symbolize_names: true)

      expect(session).to have_key(:data)
      expect(session[:data].keys).to match_array([:type, :id, :attributes])
      expect(session[:data][:attributes].keys).to eq([:email, :api_key])
    end

    it "raises an error if email is incorrect" do 
      user = User.create!(email: "whatever@example.com", password: "password1", password_confirmation: "password1")
      
      request_body = {email: "what@example.com", password: "password1"}
      headers = {"CONTENT_TYPE" => "application/json"}

      post "/api/v1/sessions", headers: headers, params: JSON.generate(request_body)

      expect(response).to_not be_successful
      expect(response.status).to eq(400)

      session = JSON.parse(response.body, symbolize_names: true)
     
      expect(session.keys).to eq([:title, :errors])
      expect(session[:errors]).to eq(["Invalid entry"])
    end

    it "raises an error is the password is incorrect" do 
      user = User.create!(email: "whatever@example.com", password: "password1", password_confirmation: "password1")
      
      request_body = {email: "whatever@example.com", password: "passwrong"}
      headers = {"CONTENT_TYPE" => "application/json"}

      post "/api/v1/sessions", headers: headers, params: JSON.generate(request_body)

      expect(response).to_not be_successful
      expect(response.status)

      session = JSON.parse(response.body, symbolize_names: true)

      expect(session.keys).to eq([:title, :errors])
      expect(session[:errors]).to eq(["Invalid entry"])
    end
  end
end