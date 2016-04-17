require 'find'

class Fetch
$files = []
$list =  {}
$pat = ARGV[0]
$dir = 'e:/confidential'
$ext = 'txt'
 
def self.file_selector
system("cls")
Fetch.list_files
Fetch.get_basefilename
Fetch.get_user_input
end

def self.list_files
  Find.find($dir) do |path|
  $files << path if path =~ /#{$pat}.*\.#{$ext}$/i
      $files.each_with_index do |index, file|
        $list[file] = index
      end
  end
end

## Get the basefile name
def self.get_basefilename
   $files.each_with_index do |file, index|
      basefile = File.basename("#{file}", ".#$ext")
      puts "#{index} => #{basefile}"
   end
end

## Run the selected file
def self.run_file
#system("Notepad @file")
$list.each do |k,v|
system %{cmd /c "start #{v}"}  if k == $index
end
## End of File Selector method
end

## Ask for index of the file or Quit
def self.get_user_input
  print "Select a file to open or 'q' to quit\n"
  print "> "
  choice = STDIN.gets.chomp
  case choice
    when 'q'
      puts "Quitting..."
      exit
   else 
     $index = choice.to_i
     run_file
     get_user_input
  end
end
#==============================================

end
## run File Selector method
Fetch.file_selector