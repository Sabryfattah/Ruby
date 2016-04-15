class WF

def intro
puts "This script print out sorted frequency of words in a text file"
puts "Enter file name"
file = gets.chomp
get(file)
end

def get(file)
text = File.read(file)
word_list = words(text)
list = count(word_list)
  list.each do |k, v| 
  puts "#{k}.....#{v}" unless v < 5
  end
end

# A method for counting frequency of words in a list
def count(word_list)
  counts =Hash.new(0)
  for word in word_list
    counts[word] +=1
  end
  #counts
  sorted = counts.sort_by{|w, count| count}.reverse
  return sorted
end

# A method which splits a string into words
def words(string)
    string.downcase.scan(/[\w']+/)
end

end
WF.new.intro