class SalariesSerializer 
  include JSONAPI::Serializer 
  set_id{nil}
  attributes :destination, :forecast, :salaries
end