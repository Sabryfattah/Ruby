data = File.read("c:/pw.txt")
sentences = data.split("\n")
puts "Enter pattern separated by spaces"
pattern = gets.chomp.upcase
sentences.each do |line|
a = pattern.split(/[\s+|\,|-|\:]/)
if a.all?{|s|"#{line.upcase}".include?(s)}
  puts line
end
end