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

get "/chocolate" do #/map is just a random path at the moment with a random name
  results = Geocoder.search(params["q"])
  #do everything else

#news API code: eca1d8895efa4e26811dece4f7ff13c6
url = "https://newsapi.org/v2/top-headlines?country=us&apiKey=eca1d8895efa4e26811dece4f7ff13c6"
news = HTTParty.get(url).parsed_response.to_hash
 #news is now a Hash you can pretty print (pp) and parse for your output

end