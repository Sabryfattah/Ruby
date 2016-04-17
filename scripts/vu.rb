class RunFile

@files = []

def getFiles
  @@paths = Dir.glob("c:/scripts/APPS/*").select { |fn| File.file?(fn) }
  @files = @@paths.map{|f| File.basename(f, "rb")}
end

def getdescription
@@all =[]
@desc = IO.readlines("c:/scripts/APPS/data/desc.txt")
@desc.each do |item|
      @fd = item.split(",")
      @@all << @fd
end

end

def fileArray
@filenames = []
@files.each do |f|
	@filenames << f
end
end

def listFiles
clear
     @filenames.each_with_index do |f, index|
	  file =  @@all[index][1] # @@all[index][0].include?"#{f}"}
	  printf("%-5d%-8s%-s", "#{index+1}", "#{f}", "#{file}")
     end
end

def userEntry
@n = "n"
  while @n != "q"
    puts "\nEnter file to run or q to quit:"
    @n = gets.chomp
   clear
   load("#{@@paths[@n.to_i-1]}")
    continue
    clear
    listFiles
  end
end

def clear
 system "cls"
end

def continue
 puts "Press any key to continue......................"
 gets
 end
 
def go
  getFiles
  getdescription
  getFiles
  fileArray
  listFiles
  userEntry
end

end


RunFile.new.go
