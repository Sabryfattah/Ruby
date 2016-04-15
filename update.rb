require 'fileutils'
require 'find'
require 'pathname'
require 'time'

class Bk
#@@directories = Dir.glob('c:/users/sabry/dropbox/desktop/*').select {|f| File.directory? f}
@@directories=[
"c:/info",
"c:/rd",
"c:/rubydoc",
"c:/scripts",
"c:/Users/Sabry/Dropbox/Desktop/AHK_APPS",
"c:/Users/Sabry/Dropbox/Desktop/CaiDec15",
"c:/Users/Sabry/Dropbox/Desktop/Important",
"c:/Users/Sabry/Dropbox/Desktop/Programming",
"c:/Users/Sabry/Dropbox/Desktop/Recent",
"c:/Users/Sabry/Dropbox/Desktop/RUBY",
"c:/Users/Sabry/Dropbox/Desktop/Samir",
"c:/Users/Sabry/Dropbox/Desktop/Scanned",
"c:/Users/Sabry/Dropbox/Desktop/Scan_Cabinet",
"c:/Users/Sabry/Dropbox/Desktop/scripts",
"c:/Users/Sabry/Dropbox/Desktop/vim"
]

@@dst = "e:/backup"

def start
  puts "Update Tool".center(80)
  puts "-"*87
  puts "Update backup from selected directories"
  puts @@directories
  puts "to backup folder in e:/backup"
  puts "="*87
  update
end


def update
@@directories.each do |dir|
	 files = get_files(dir)
	 file = files.select { |f| File.file?(f) }
	 newfiles = selectNewFiles(file)
	 puts "................... No new files to copy ....................................." if newfiles.empty?
	 newfiles.each do |f|
	     dir = File.dirname(f)
		dst =  dir.sub(/^../, "#{@@dst}")
    		FileUtils.mkdir_p(dst) unless File.directory?(dst)  
	 end
	 newfiles.each do |f|           
		 src = f
		 dst =  f.sub(/^../, "#{@@dst}")
		FileUtils.cp(src, dst)
	     puts "Copying #{src}...to..#{dst}"
		 
	end
end
	
end

def get_files(src)
@@files = []
list = Find.find(src)
list.each do |f|
@@files << f.force_encoding(Encoding::UTF_8)
end
return @@files
end


def selectNewFiles(files)
   @@new_files = files.select{|f| File.mtime(f) > (Time.now) - (60*60*240)} ## > (Time.now) - (60*60*24)} means one day
end

end


Bk.new.start

