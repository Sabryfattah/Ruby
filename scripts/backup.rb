require 'fileutils'
require 'find'
require 'pathname'
require 'time'

class Backup

def start
  puts "Backup Tool".center(80)
  puts "-"*87
  puts "a : move folder and all files and subfolders to destination"
  puts "u: update destination folder by files modified within last 10 days"
  puts "="*87
  puts "Enter choice"
  choice = gets.chomp
  case choice
    when "a"
	backup
    when "u"
     update
  end
end

def backup
     puts "Enter source folder:# e.g. c:/top_folder"
     @@src = gets.chomp
 	puts "Enter destination folder or drive #e.g. d:"
     @@dst = gets.chomp
	get_files(@@src)
	@@dir = @@files.select{|d| File.directory?(d)}
	@@dir.each do |d|
	   d = d[2..-1]
	   mk_dir_tree(@@src,"#{@@dst}#{d}")
	end
	@@file = @@files.select { |f| File.file?(f) }
	copy_files(@@file, @@dst)
end

def update
	puts "Enter source folder:# e.g. c:/top_folder"
     @@src = gets.chomp
     puts "Enter destination folder or drive #e.g. d:"
     @@dst = gets.chomp 
	 files = get_files(@@src)
	 file = files.select { |f| File.file?(f) }
	 newfiles = selectNewFiles(file)
	 puts "................... No new files to copy ....................................." if newfiles.empty?
	newfiles.each do |f|
	      src = f
		 dst =  f.sub(/^../, "#{@@dst}")
		FileUtils.cp(src, dst)
	     puts "Copying #{src}...to..#{dst}"
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

def mk_dir_tree(src, dst)
#split the path into folder and subfolders -> array[folder, subfolder]->@@path
# @@path = Pathname(src).each_filename.to_a
#  d = @@path.unshift(dst)
#  @@dst = d.join("/")
p dst
FileUtils.mkdir_p(dst) unless Dir.exists?(dst)
end

def copy_files(files, dst)
    files.each do |f|
     p = f.split('/')
     p[0] = "#{@@dst}"
     @@dst_file = p.join('/')
         if File.file?(f)
              FileUtils.cp(f, @@dst_file)
              puts "copying ...#{f} \n to ........ #{@@dst_file}"
          end
    end
end

def selectNewFiles(files)
   @@new_files = files.select{|f| File.mtime(f) > (Time.now) - (60*60*240)} ## > (Time.now) - (60*60*24)}
end

end

Backup.new.start
