#search a file for multiple words and display each paragraphs containing those words
class Dict

@@folder = ARGV[0] ||"info"

def self.wrap(s, width=85)
	  s.gsub(/(.{1,#{width}})(\s+|\Z)/, "\\1\n")
end

def self.list_dir
#get list of files in the selected directory
@files = Dir.glob("c:/#{@@folder}/*.txt")
end

def self.file_list
    list_dir
	clear
	sep
	list = []
	@files.each_with_index do |f, index|
	  index = index + 1
	  index =  format('%02d', "#{index}")
	  f = File.basename("#{f}", ".txt")
	  list << "#{index} ....#{f}"
	end
	list.each_slice(2) { |row| puts row.map{|e| "%-30s" % e}.join("        ") }
	sep
end

def self.continue
puts "="*87
puts "[Press Any key to continue........................]"
STDIN.gets
end

def self.search_selected
list_dir
file_list
print "     Select file number to search or 'q' to quit    \n"
  print "> "
  choice = STDIN.gets.chomp
  index = choice.to_i
  unless choice == 'q'
    system "cls"
	input_pattern
    @selected_file = "#{@files[index-1]}"
	puts file_search("#{@selected_file}", "#{@pattern}")
	continue
	usr_select
  else
     system "cls"
     exit
  end
end

def self.file_search(file, pattern)
result = []
data = File.read(file)
sentences = data.split("\n\n\n")
pattern = pattern.upcase
sentences.each do |line|
pat = pattern.split(/[\s+|\,|-|\:]/)
result <<"#{"="*85}" <<"#{file}\n" <<"#{"="*85}" << "#{line}"   if pat.all?{|s|"#{line.upcase}".include?(s)}
end
return result
continue
clear
sep
usr_select
end

def self.sep
puts "="*87
end

def self.clear
system "cls"
end

def self.input_pattern
	print "Enter Pattern to search:"
     print "> "
	@pattern = STDIN.gets.chomp
end

def self.usr_select
clear
puts "select from available choices:
f : Select a file and search it.
a : Search all files in the directory
e : edit selected file
q : quit"
sep
choice = STDIN.gets.chomp
case choice
 when 'f'
   system "cls"
   search_selected
 when 'a'
   search_all
 when 'e'
   edit_files
 when 'q'
   system "cls"
      exit
  end
  usr_select
 end
  

def self.search_all
  @files = list_dir
  input_pattern
  @array = []
  @files.each do |f|
    found =   file_search("#{f}", @pattern)
	if found !=  ""
	  @array << found 
	end
  end
  clear
  puts @array
  continue
  usr_select
end

def self.edit_files
list_dir
file_list
print "     Select file number to search or 'q' to quit    \n"
  print "> "
  choice = STDIN.gets.chomp
  index = choice.to_i
  unless choice == 'q'
    system "cls"
    @selected_file = "#{@files[index-1]}"
	system "c:/vim/vim #{@selected_file}"
	continue
	usr_select
  else
    usr_select
  end
end

end #End class

Dict.usr_select

