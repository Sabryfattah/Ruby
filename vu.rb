class RunFile

@files = []

#get file list in directory->@files
def getFiles
  @@paths = Dir.glob("c:/scripts/APPS/*").select { |fn| File.file?(fn) }
  @files = @@paths.map{|f| File.basename(f, ".rb")}
end

#get description from txt file -> @@all array
def getdescription
@@all =[]
@desc = IO.readlines("c:/scripts/APPS/data/desc.txt")
@desc.each do |item|
      @fd = item.split(",")
      @@all << @fd
end
end

# put filenames in array -> @filenames
def fileArray
@filenames = []
@files.each do |f|
	@filenames << f
end
end

# print out files index, name and description
def listFiles
clear
require "c:/scripts/APPS/archive/dt.rb"
puts "="*87
     @filenames.each_with_index do |f, index|
	  file =  @@all[index][1] # @@all[index][0].include?"#{f}"}
	  printf("%-5d%-8s%-s", "#{index+1}", "#{f}", "#{file}")
     end
end

#ask user to chose a file -> @n, -> runFile
def userEntry
puts "\nEnter file number  to run or 'q' to quit:"
 @n = gets.chomp
 while @n != "q"
     runFile
 end
   exit
end

def runFile
     clear
     load "#{@@paths[@n.to_i-1]}"
	continue
	go
end

#clear screen
def clear
 system "cls"
end

# wait for any key to continue
def continue
 puts "Press any key to continue......................"
 gets
 end
 
# run the script
def go
  getFiles
  getdescription
  fileArray
  listFiles
  userEntry
end

end


RunFile.new.go
