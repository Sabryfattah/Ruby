@files = Dir.glob("c:/Scripts/APPS/csv/*.csv")
@files.each_with_index do |file, index|
 puts "#{index+1} :: #{File.basename(file)}"
end

puts "Select file number to open"
n = gets.chomp.to_i
f = File.basename("#{@files[n - 1]}", ".csv")
puts f
system("ruby c:/Scripts/APPS/csv/csv.rb #{f}")
