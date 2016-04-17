#A class to search a text file and fetch a string matching a Regex pattern
# user provides the name of the file without extension and the Regex matching pattern
class H
@pattern = ARGV[0]
@dir = ARGV[1]
@files = []

def self.get_files
@files = Dir.glob("#@dir/**/*.txt")
end

def self.sep1
print "===================================================================\n"
end

def self.sep2
print "__________________________________________________________________________________________\n"
end

def self.fetch(file, match)
h = Hash[File.read("#{file}").split("\n").map{|i| i.split(', ')}]
m = h.keys
key = m.grep(/#{match}/i)
arr = []
key.each{|a|   arr.push(a," \n ", h.fetch(a), " \n")}
return arr.join("")
end

def self.get_it
list = H.get_files
list.each do |f|
r =  H.fetch(f, ARGV[0])
if r != ""
puts r 
print "=====>     #{f}\n"
H.sep2
end
end
end



end



H.get_it













