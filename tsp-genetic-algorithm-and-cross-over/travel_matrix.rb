require 'matrix'
require 'open-uri'
require 'nokogiri'
require 'json'
require 'dotenv/load'

class TravelMatrix
  def self.generate(sights, travel_mode)
    times = Matrix.build(sights.length, sights.length) { |row, col| { start: sights[row], end: sights[col] } }
    key = ENV['GOOGLE_API_SERVER_KEY']
    times.each_with_index do |cell, row, col|
      url = "https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=#{cell[:start][0]},#{cell[:start][1]}&destinations=#{cell[:end][0]}%2C#{cell[:end][1]}&mode=#{travel_mode}&key=#{key}"
      serialized = open(url).read
      info = JSON.parse(serialized)
      times[row, col] = info['rows'][0]['elements'][0]['duration']['value']
    end
  end
end
