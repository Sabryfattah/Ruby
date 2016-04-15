class GetString
@pattern = "readlines"
@dir  = "c:/rd"
def start
puts "="*87
puts "Search text files and fetch paragraphs containing a string matching a Regex pattern.\nThe user provides the name of the folder and the Regex matching pattern.\nTo fetch a praticular phrase enter its regex pattern
\^	Start of string, or start of line in multi-line pattern
\$	End of string, or end of line in multi-line pattern
\\b	Word boundary
\\<	Start of word
\\>	End of word
\\s	White space
\\d	Digit
\\w	Word
?=	Lookahead assertion
?!	Negative lookahead
?<=	Lookbehind assertion
?!= 	Negative lookbehind(or ?<!)
*	0 or more
{3}	Exactly 3
+	1 or more
{3,}	3 or more
?	0 or 1
{3,5}	3, 4 or 5
Add a ? to a quantifier to make it ungreedy.
\\	Escape following character
\\n	New line
\\r	Carriage return
\\t	Tab
\.	Any character except new line \(\\n\)
(a|b)	a or b
(...)	Group
[abc]	Range (a or b or c)
[^abc]	Not (a or b or c)
[a-q]	Lower case letter from a to q
[A-Q]	Upper case letter from A to Q
[0-7]	Digit from 0 to 7
/../i 	Case-insensitive
/../m	Multiple lines
/../s	Treat string as single line
$`	Before matched string
$'	After matched string
$+	Last matched string
$&	Entire matched string
 ".center(80)
puts "="*87
  puts "Enter pattern to search for"
  @pattern = gets.chomp
  puts "Enter Directory to search in"
  @dir = gets.chomp
clear
puts "="*87
@files = []
get_it unless @pattern == "" or @dir == ""
continue
end

def get_files
@files = Dir.glob("#@dir/**/*.txt")
end

def fetch(file, match)
@hash = Hash[File.read("#{file}").split("\n\n").map{|i| i.split('\n\n')}]
@m = @hash.keys
match = match.split(" ")
match =  match.join(".*?")
@key = @m.grep(/#{match}/mi)
@arr = []
@key.each{|a|   @arr.push(a," \n\n", @hash.fetch(a), "\n","-"*87,"\n")}
return @arr.join("")
end

def get_it
@filelist = []
list = get_files
 list.each do |f|
    r = fetch(f, @pattern)
    if r != ""
      puts r 
      print "found in =====>     #{f}\n"
	  @filelist << "#{f}"
      sep2
    end
end
   open_file
end

def sep1
print puts "="*87
end

def sep2
puts "_"*87
end

def continue
 puts "Enter 'c' to continue or 'q' to quit .................."
 entry = gets.chomp
 if entry == "c"
    clear
    start
 elsif entry == "q"
  exit
 end
end

def clear
system "cls"
end

def open_file
	@filelist.each_with_index do |f, index|
	    puts "#{index.to_i+1}......#{f}"
	end
	puts "To read more, select file number from list above"
	selection = gets.chomp
    selected_file = @filelist[selection.to_i - 1]
	if selection != ""
      array = File.read("#{selected_file}").split("\n\n\n")
	  match = @pattern.split(" ").join(".*?")
	  clear
	  sep1
        puts  array.select{|i| i[/#{match}/mi]} 
	  sep2
	end
	continue
end
end
GetString.new.start













