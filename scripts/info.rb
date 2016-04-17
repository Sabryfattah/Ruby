class Dict
@dir = "c:/info"

def self.wrap(s, width=85)
	  s.gsub(/(.{1,#{width}})(\s+|\Z)/, "\\1\n")
end

def self.list_dir
#get list of files in the selected directory
@files = Dir.glob("#@dir/*.txt")
end

def self.file_list
     list_dir
	clear
	sep
	@files.each_with_index do |f, index|
	f = File.basename("#{f}", ".txt")
	puts "#{index+1} ....#{f}"
	end
	sep
end

def self.continue
puts "="*87
puts "[Press Any key to continue........................]"
gets
end

def self.search_selected
list_dir
file_list
print "     Select file number to search or 'q' to quit    \n"
  print "> "
  choice = gets.chomp
  index = choice.to_i
  unless choice == 'q'
     system "cls"
	input_pattern
     @selected_file = "#{@files[index-1]}"
	file2hash("#{@selected_file}", "#{@pattern}")
	continue
  else
     system "cls"
      exit
  end
end

def self.file2hash(file, match)
file = @selected_file 
# read file into a hash, split data chunks by ======, and split each chunk by ==>
@hash = Hash[File.read("#{file}").split('=====').map{|i| i.split('==>')}]
# get hash keys into variable allkeys
@all_keys = @hash.keys
# select the keys matching the pattern 'match'
@m_keys = @all_keys.grep(/#{match}/i)
# create an empty array 'arr'
@arr = []
# for each key matching, add the value of that key to the empty array 'arr'
@m_keys.each{|a| @arr.push(a, @hash.fetch(a))}
list_keys
end

def self.list_keys
 clear
 sep
@m_keys.each_with_index do |d, index|
  unless d == "" 
    printf("%d%s", "#{index+1}", "\t : #{d} \n")
  end
end
sep
key_select
end

def self.key_select
    print "     Select number or 'q' to quit    \n"
    print "> "
    choice = gets.chomp
    index = choice.to_i
  unless choice == 'q'
     system "cls"
     clear
	@hash.each{|k,v| puts "#{v} \n=== #{k}.. in .. #{@file} ===\n" if k == @m_keys[index-1]}
	continue
	clear
	usr_select
  else
     system "cls"
      exit
  end
end

def self.usr_select
puts "select from available choices:
a : Select a file.
c : Select a key from file #{@selected_file}
s : Search all keys in the directory
v : Search all values in the directory
p : Search values by paragraph in the directory
q : quit"
sep
choice = gets.chomp
case choice
 when 'a'
   system "cls"
   search_selected
 when 'c'
   system "cls"
   list_keys
   key_select
 when 's'
   search_allkeys
 when 'v'
   search_values
 when 'p'
   search_para
 when 'q'
   system "cls"
      exit
  end
  
 end
 
def self.sep
puts "="*87
end

def self.clear
system "cls"
end

def self.search_allkeys
 list_dir
 input_pattern
 array = []
  @files.each do |file|
    hash = Hash[File.read("#{file}").split("=====").map{|i| i.split('==>')}]
    all_keys = hash.keys
    m_keys = all_keys.grep(/#{@pattern}/i)
    m_keys.each{|a| 
	array.push("#{a}","\n","_"*87, "\n", 
	     hash.fetch(a),"="*87, "\n","^"*30," File: #{file} ","^"*30,"\n","="*87,"\n")
		           }
  end
    clear
    content = array.join("")
    print "#{content}"
    continue
    clear
    usr_select
end

def self.input_pattern
	print "Enter Pattern to search:"
     print "> "
	@pattern = gets.chomp
end

def self.search_all_values
@values = []
@matching_values = []
@list = []
list_dir
input_pattern
@files.each do |f|
@hash = Hash[File.read("#{f}").split("=====").map{|i| i.split('==>')}]
@file = "#{f}"
@all_keys = @hash.keys
           @all_keys.each do |k|
			@values.push(@hash[k])
			@values.push("\n^^^^^^^#{k} in #{@file}   ^^^^^^^")
			@matching_values = @values.grep(/#{@pattern}/i)
	      end
end
@list = @matching_values.map{|x| x+ "\n================================================================================ "}
content = @list.join("")
clear
puts "#{content}"
continue
clear
usr_select
end


def self.search_values
@content = []
@matching_values = []
@array = []
@files = Dir.glob("#@dir/*.txt") #"c:/rubydoc/array.txt" 
print "Enter Pattern to search within ():"
print "> "
@pattern = gets.chomp
@files.each do |file|
hash = Hash[File.read("#{file}").split("=====").map{|i| i.split('==>')}]
all_values = hash.values
  all_values.each{|value| 
	      if value =~ /#{@pattern}/
	         @array.push("#{value}","\n","_"*87, "\n", "="*87, "\n","^"*20," File: #{file} ","^"*20,"\n","="*87,"\n")
		   @content = @array.join("")
	      end
	}
end
   clear
   puts wrap("#{@content}")
   Dict.usr_select
end

def self.search_para #def
@array = []
@files = Dir.glob("#@dir/*.txt")
print "Enter Pattern to search within ():"
print "> "
@match = gets.chomp
@files.each do |file| #files
hash = Hash[File.read("#{file}").split("=====").map{|i| i.split('==>')}]
all_values = hash.values
all_values.each do |value|  #values
	@para = value.split("\n\n") unless value == nil
	@para.each do |para| #para
	      if para =~ /#{@match}/ #match
	       @array.push("#{para}","\n","_"*87, "\n", "="*87, "\n","^"*30," File: #{file} ","^"*30,"\n","="*87,"\n")
	       @content = @array.join("")
		end  #match
	end  #para
end  #values
end #files
     clear
	puts wrap("#{@content}")
	Dict.usr_select
end #def


end #End class




Dict.usr_select
