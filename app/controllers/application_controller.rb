class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordInvalid, with: :bad_request_response 

  def bad_request_response(exception)
    render json: ErrorSerializer.new(exception.message).bad_request, status: 404
  end
end
