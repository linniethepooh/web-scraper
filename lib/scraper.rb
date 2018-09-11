require 'open-uri'
require 'nokogiri'
require 'pry-byebug'
require 'json'

def scraper

url = 'http://www.wegottickets.com/searchresults/all'
html = open(url)

doc = Nokogiri::HTML(html)
events = []

doc.search('.content.block-group.chatterbox-margin').each do |event|
      # binding.pry

  events.push(
    artist: event.search('.event_link').text.strip,
    city: event.search('.venue-details h4')[0].text.strip.split(':').first,
    venue: event.search('.venue-details h4')[0].text.strip.split(':').last,
    date: event.search('.venue-details h4')[1].text.strip,
    price: event.search('.searchResultsPrice').text.strip
  )
end

puts events

json = JSON.pretty_generate(events)
File.open("data.json", 'w') { |file| file.write(json) }

end

scraper


