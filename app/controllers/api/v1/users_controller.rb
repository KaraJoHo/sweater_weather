class Api::V1::UsersController < ApplicationController
  def create 
    render json: UsersSerializer.new(User.create!(user_params)), status: :created
  end

  private
    def user_params
      params.permit(:email, :password, :password_confirmation)
    end
end