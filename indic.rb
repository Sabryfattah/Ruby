class Indictionary

def write_content
  print "Enter Heading \n >> "
  @heading = gets.chomp
  print "Write subject and finish by '**': \n >> "
  @data = []
  while(a=STDIN.gets.chomp) !='**'
    @data.push(a)
  end
  @content  =<<"EOF"
===== #{@heading} ==>\n
#{@data.join("\n")}\n
EOF
end

def input_filename
  print "Enter filename or Press Enter for previous file\n >>  "
  file = gets.chomp
      if file == ""
	  @file = @file
	 else
	  @file = "c:/info/#{file}\.txt"
	  end
end
	  
def read_file
       unless File.exist?(file)
             File.open(@file, 'a'){|f| f.puts "#{@content}"}
       else
             File.open(@file, 'w'){|f| f.puts "#{@content}"}
        end
end

def intro
puts "WELCOME".center(60)
puts "="*87
puts "Info Entry Form".center(60)
puts "_"*87
puts "This tool allows you to enter key:value into a file in the 'c:/Info' Directory.
You start by entering a Heading then a Subject and finish by **
If the file is already there, your entry willl be appended to it.
If no such file is there, it will be created.
Continue entering information, when finished, enter xx to exit\n"
puts "Press any key to continue................. ".center(20)
puts "_"*87
gets
end

def start
system "cls"
print "Press Any Key to continue or xx to exit\n >>  "
     input = gets.chomp
      unless input == 'xx'
      	puts "Current File : #{@file}"
          indictionary
       else
          puts "Quitting..."
          exit
      end
end
	 
def go
 intro
 start
end


end

Indictionary.new.go

  