file = "c:\\pw.txt"
File.foreach(file).with_index do |line, index| 
  puts "#{index}: #{line}" if line =~ /#{ARGV[0]}/im
end