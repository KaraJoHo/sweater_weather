class Api::V1::SalariesController < ApplicationController 
  def index 
  #  require 'pry'; binding.pry
    if params[:destination].nil? || params[:destination] == ""
      render json: ErrorSerializer.new("No location provided").bad_request, status: 400
    else
      salary_info_for_destination = SalariesFacade.new(params[:destination])
      render json: SalariesSerializer.new(salary_info_for_destination.salaries_for_destination)
    end
  end
end