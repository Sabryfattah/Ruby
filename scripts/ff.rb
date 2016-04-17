require 'find'
puts "This script will find path of a file in a directory or drive"
puts "Enter drive or directory"
dir = gets.chomp
puts "Enter pattern of file, e.g. app.*  if it starts with app or .*app if it ends with app"
pattern = gets.chomp
puts "Enter extension"
ext = gets.chomp

#file = Dir.glob("#{dir}/**/#{pattern}\.#{ext}")

p Find.find("#{dir}/") do |f| p f end