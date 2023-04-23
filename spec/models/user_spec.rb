require "rails_helper"

RSpec.describe User do 
  describe "validations" do 
    it {should validate_presence_of :email}
    it {should validate_uniqueness_of :email}
    it {should validate_presence_of :password}
    it {should validate_confirmation_of :password}
    it {should have_secure_password}
  end

  describe "creating a new user" do 
    it "creates a new user with a password" do
      user = User.create!(email: "bob@test.com", password: "password123")
      expect(user).to_not have_attribute(:password)
      expect(user.password_digest).to_not eq("password123")
      expect(user).to have_attribute(:api_key)
    end
    
    it "makes sure the password and confirmation match" do 
      user = User.create!(email: "meg@test.com", password: "password123", password_confirmation: "password123")
      
      expect(user.password_confirmation).to_not eq("password")
    end
  end

  describe "class methods" do 
    it "is a list of all api keys" do 
      user = User.create!(email: "user@email.com", password: "passed", api_key: "123")
      user = User.create!(email: "userrr@email.com", password: "passed", api_key: "777")
      expect(User.all_keys).to eq(["123", "777"])
    end
  end
end