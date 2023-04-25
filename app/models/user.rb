class User < ApplicationRecord 
  has_secure_token :api_key
  validates_presence_of :email, :password
  validates_uniqueness_of :email
  validates :password, confirmation: true
 
  has_secure_password

  def self.all_keys 
    pluck(:api_key)
  end
end