def wrap(s, width=85)
	  s.gsub(/(.{1,#{width}})(\s+|\Z)/, "\\1\n")
end

@pattern = ARGV[0]
string = []
txtfiles = Dir.glob("c:/test/*\.txt")
txtfiles.each do |txtf|
  array = File.read("#{txtf}").split("\n\n")
  match = @pattern.split(" ").join(".*?")
  item = array.select{|i| i[/#{match}/i]}
  file = ["\n\n#{'='*87}\n\nFound in #{txtf}\n\n"]
  string << item+file unless item == []
end
string.each do |s|
 s = s.join
 puts wrap("#{s}") 
 puts "="*87
end
