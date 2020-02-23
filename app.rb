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

get "/news" do #/map is just a random path at the moment with a random name
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
@headlines = headlines

#view "ask"

#for authors in headlines[]
 #   headlines << "#{authors} did this work?????"
#end
#@headlines
#for source in headlines
 # puts "will this show the XYZ #{source[:"source"][:"name"]}"
#end

#fix extended forecast somehow

#{headlines[0]["source"]["name"]} #{headlines[0]["author"]} #{headlines[0]["title"]} #{headlines[0]["content"]}#{headlines[0]["url"]}
#"
#<p></p>
#<p></p>
#<p></p>
#In #{lat_long[0]} #{lat_long[1]}, it is currently #{current_temperature} and #{current_conditions}.
#Extended forecast:
#A high temperature of #{forecast["daily"]["data"][0]["temperatureHigh"]} and #{forecast["daily"]["data"][0]["summary"]}
#A high temperature of #{forecast["daily"]["data"][1]["temperatureHigh"]} and #{forecast["daily"]["data"][1]["summary"]}
#A high temperature of #{forecast["daily"]["data"][2]["temperatureHigh"]} and #{forecast["daily"]["data"][2]["summary"]}
#A high temperature of #{forecast["daily"]["data"][3]["temperatureHigh"]} and #{forecast["daily"]["data"][3]["summary"]}
#A high temperature of #{forecast["daily"]["data"][4]["temperatureHigh"]} and #{forecast["daily"]["data"][4]["summary"]}
#A high temperature of #{forecast["daily"]["data"][5]["temperatureHigh"]} and #{forecast["daily"]["data"][5]["summary"]}
#A high temperature of #{forecast["daily"]["data"][6]["temperatureHigh"]} and #{forecast["daily"]["data"][6]["summary"]}
#<p></p>
#A high temperature of #{forecast["daily"]["data"][7]["temperatureHigh"]} and #{forecast["daily"]["data"][7]["summary"]}"

  #do everything else
  #results = Geocoder.search(params["q"])
#news API code: eca1d8895efa4e26811dece4f7ff13c6
#url = "https://newsapi.org/v2/top-headlines?country=us&apiKey=eca1d8895efa4e26811dece4f7ff13c6"
#news = HTTParty.get(url).parsed_response.to_hash
# news is now a Hash you can pretty print (pp) and parse for your output

view "ask"

end