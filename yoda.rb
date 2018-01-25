# Make yoda speak the weather.
# Get the current weather from weather api
# 25.8028299,-80.2065428,

require 'httparty'
# require 'nokogiri'
# require 'open-uri'
require 'sinatra'

get '/' do
  # your_location = location

  erb :location

  lat_lon = [25.8028299, -80.2065428]
  p @lat
  p @lon

  weather_response = HTTParty.get("https://simple-weather.p.mashape.com/weather?lat=#{lat_lon[0]}&lng=#{lat_lon[1]}",
                                  headers: {
                                    'X-Mashape-Key' => '3JvntCfhQemshL1jaX5BVmt1fIxVp1qDKepjsn8XR84ekQyEDy',
                                    'Accept' => 'text/plain'
                                  })

  @weather = weather_response.parsed_response.split(',')

  city = @weather[1].split(' ')[2]

  condition = @weather[1].split(' ')[0].downcase

  temp = @weather[0].split(' ')[0]

  unit = if @weather[0].split(' ')[1] == 'c'
           'celcius'
         else
           'farenheight'
          end

  @weather = "The temperature in #{city} is #{temp} degrees #{unit}. The weather is #{condition}."

  yoda_response = HTTParty.get("https://yoda.p.mashape.com/yoda?sentence=#{@weather.split(' ').join('+')}",
                               headers: {
                                 'X-Mashape-Key' => '3JvntCfhQemshL1jaX5BVmt1fIxVp1qDKepjsn8XR84ekQyEDy',
                                 'Accept' => 'text/plain'
                               })

  if yoda_response.response.code != '200'
    # @weather
    erb :display
  else
    @weather = yoda_response.parsed_response
    erb :display
  end
end

post '/go' do
  @lat = params[:lat]
  @lon = params[:lon]
  # erb :index
end

# def location
#   page = 'http://freegeoip.net/json/'
#   doc = Nokogiri::HTML(open(page, 'User-Agent' => 'ruby'))
#   loc = /(latitude)(\":)(\d+.\d+)(,\"longitude\":)(-\d+.\d+)/.match(doc.text)
#   lat = loc[3]
#   lon = loc[5]
#   [lat, lon]
# end
# tts_response = HTTParty.get("https://voicerss-text-to-speech.p.mashape.com/?key=d57edec0365d484f8b005c81ddadc14c&c=mp3&f=8khz_8bit_mono&hl=en-us&r=0&src=#{yoda_weather.split(" ").join("+")}",
#   headers:{
#     "X-Mashape-Key" => "3JvntCfhQemshL1jaX5BVmt1fIxVp1qDKepjsn8XR84ekQyEDy"
#   })
#
#   #write it to a file
#
#   File.open('yoda_weather.mpeg','w') {|file| file.write(tts_response.parsed_response)}
#
