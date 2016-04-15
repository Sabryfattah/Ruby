 require 'find'

class Fetch
#variables
@@files = []
@@list =  {}
@@dir = 'e:/confidential'
@@ext = 'txt'

#get search pattern
 def userEntry
 puts "Enter pattern in filename to search:"
 @@pattern = gets.chomp
 end

#get fileList  matching pattern
def fileList
  Find.find(@@dir) do |path|
  @@files << path if path =~ /#{@@pattern}.*\.#{@@ext}$/i
      @@files.each_with_index do |index, file|
        @@list[file] = index
      end
  end
end

## Get the basefile Filename
def get_basefilename
   @@files.each_with_index do |file, index|
      basefile = File.basename("#{file}", ".#{@@ext}")
      puts "#{index} => #{basefile}"
   end
end
def get_user_input
  print "Select a file to open or 'q' to quit\n"
  print "> "
  choice = gets.chomp
while choice != "q"
     $index = choice.to_i
     run_file
     get_user_input
end
require"c:/vu.rb"
end

## Run the selected file
def run_file
#system("Notepad @file")
@@list.each do |k,v|
system %{cmd /c "start #{v}"}  if k == $index
end
## End of File Selector method
end

## Ask for index of the file or Quit
#==============================================
def file_selector
system("cls")
userEntry
fileList
get_basefilename
get_user_input
end

end
## run File Selector method
Fetch.new.file_selector