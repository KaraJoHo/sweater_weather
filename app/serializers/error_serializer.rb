class ErrorSerializer 
  def initialize(errors)
    @errors = errors
  end

  def bad_request 
    {
      title: "Invalid Request",
      errors: [@errors]
    }
  end
end