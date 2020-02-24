require "sinatra"
require "sinatra/reloader"
require "geocoder"
require "forecast_io"
require "httparty"
def view(template); erb template.to_sym; end
before { puts "Parameters: #{params}" }                                     

# enter your Dark Sky API key here
ForecastIO.api_key = "34a5c5394a5b9ab52c00af35bd1959e1"

get "/" do
  view "geocode"
end

get "/news" do 
  results = Geocoder.search(params["q"])
  lat_long = results.first.coordinates # => [lat, long]
  @lat = lat_long[0] 
  @long = lat_long[1] 
  @lat_long = "#{@lat},#{@long}" 
  @location = results.first.city

  forecast = ForecastIO.forecast(@lat,@long).to_hash

@current_temperature = forecast["currently"]["temperature"]
@current_conditions = forecast["currently"]["summary"]
@day = forecast["daily"]["data"]

@url = "https://newsapi.org/v2/top-headlines?country=us&apiKey=eca1d8895efa4e26811dece4f7ff13c6"
news = HTTParty.get(@url).parsed_response.to_hash

headlines = news["articles"]
@headlines = headlines.slice(0, 10)

view "ask"

end