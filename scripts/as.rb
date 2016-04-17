## Display all first sentences in a file
require_relative "abr"
require_relative "ab"


class AS

def self.all_sentences
clear
### Prepare the file by processing it and get all_sentences
Ab.prepare
puts @all_sentences
print "Press Any Key to Continue.........."
gets
choice
end

end