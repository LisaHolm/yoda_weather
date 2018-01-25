#Make yoda speak the weather.
#Get the current weather from weather api
#25.8028299,-80.2065428,

require 'httparty'

weather_response = HTTParty.get("https://simple-weather.p.mashape.com/weather?lat=25.8028299&lng=-80.2065428%2C",
  headers:{
    "X-Mashape-Key" => "3JvntCfhQemshL1jaX5BVmt1fIxVp1qDKepjsn8XR84ekQyEDy",
    "Accept" => "text/plain"
  })

  weather =  weather_response.parsed_response.split(',')

  city = weather[1].split(" ")[2]

  condition = weather[1].split(" ")[0].downcase

  temp = weather[0].split(" ")[0]

  unit =  "celcius" if weather[0].split(" ")[1] == 'c'

  pp weather =  "The temperature in #{city} is #{temp} degrees #{unit} and the weather is #{condition}."

  yoda_response = response = HTTParty.get("https://yoda.p.mashape.com/yoda?sentence=#{weather.split(" ").join("+")}",
  headers:{
    "X-Mashape-Key" => "3JvntCfhQemshL1jaX5BVmt1fIxVp1qDKepjsn8XR84ekQyEDy",
    "Accept" => "text/plain"
  })

  pp yoda_weather = yoda_response.parsed_response

  tts_response = # These code snippets use an open-source library. http://unirest.io/ruby
pp response = HTTParty.get("https://voicerss-text-to-speech.p.mashape.com/?key=d57edec0365d484f8b005c81ddadc14c&c=mp3&f=8khz_8bit_mono&hl=en-us&r=0&src=#{yoda_weather.split(" ").join("+")}",
  headers:{
    "X-Mashape-Key" => "3JvntCfhQemshL1jaX5BVmt1fIxVp1qDKepjsn8XR84ekQyEDy"
  })
