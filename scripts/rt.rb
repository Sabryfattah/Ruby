## Clear screen
@dir = 'C:/Users/Sabry/Desktop/RUBY/Demo'

def clear
system "cls"
end

##Press any key to continue
def continue
puts "\nPress any key to continue ........\n"
gets
clear
end

## Enter code on screen and put it into array @data
def write_tmp
puts "enter code and finish with **"
puts "="*87
@data = []
while(a=STDIN.gets.chomp) !='**'
@data.push("#{a}\n")
end
## process data
get_tmp
end


def get_tmp
clear
## write data to tmp.rb
File.open("tmp.rb", 'w:UTF-8') { |file| file.write("#{@data.join("")}") }
## run tmo.rb
result = `ruby tmp.rb  2>&1`
## write result to a file
IO.write("out.txt", result)
## get file into a variable out
out = IO.read("out.txt")
### Prepare screen
## write CODE at center
puts "  CODE  ".center(86, "||")
## Separator
puts"_"*87
## show file name
puts "FILENAME: #{@filename}"
##separator
puts "_"*87
### write data to screen with line numbers
n = 0
@data.each_with_index do |line, index|
puts "#{index+1} - #{line}"
n += 1
end
#print "#{@data.join("")}\n"
## separator
puts "_"*87
### write OUTPUT at center of line
puts "  OUTPUT  ".center(86, "||")
##separator
puts "_"*87
### write out variable
puts out
## separator
puts "_"*87
### press to coninue
continue
### back to menu
menu
end

def  menu
puts "="*87
puts "  Interactive Ruby Commandline Tool  ".center(87, "[]")
puts "="*87
puts "select from available choices:
<c> Enter code (write code)
<r> Run tmp.rb (test code)
<e> Edit code  (edit tmp.rb in vim)
<l> Load and run saved file
<s> Save code to a new filename
<q> Quit"
print "="*87
print "\n>>"
choice = gets.chomp
case choice
 when 'c'
   clear
   write_tmp
 when 'r'
   reload_tmp
 when 's'
   save_file
 when 'e'
   system "cls"
   edit_code
  when 'l'
   system "cls"
   load_file
 when 'q'
   system "cls"
   exit
end
  
end

def  save_file
puts "Save code to file .....{enter filename}"
@filename = gets.chomp
content = IO.read("tmp.rb")
File.open("#{@dir}/#{@filename}\.rb", 'w:UTF-8') { |file| file.write("#{content}") }
menu
end

# Reload @data from tmp.rb file
def reload_tmp
@data = IO.readlines("tmp.rb")
get_tmp
end

def edit_code
system "c:/vim/vim tmp.rb"
menu
end

def  load_file
puts "type Directory or press Enter:"
print ">>"
@dir = gets.chomp 
  if @dir == ""
     @dir = 'C:/Users/Sabry/Desktop/RUBY/Demo'
  end
@files = Dir.glob("#{@dir}/*.rb")
puts "="*87
@basenames = []
  @files.each_with_index do |f, index|
     @file = File.basename(f)
	@basenames << "#{@file}"
     puts "#{index} ...#{@file}"
  end
puts "="*87
print "Enter file number to load\n>>"
n = gets.chomp
@filename = @basenames[n.to_i]
@data  = IO.readlines("#{@dir}/#{@filename}")
get_tmp
end

menu