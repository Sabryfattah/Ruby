require 'open-uri'
require 'nokogiri'

url = 'http://en.wikipedia.org/wiki/Wolfram_language'
doc = Nokogiri::HTML(open(url))

text = ''
doc.css('p,h1').each do |e|
  text << e.content
end

puts text