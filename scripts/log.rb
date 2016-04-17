require 'fileutils'

class Journal

#Assign variables
#file is first commandline argument
@@file = ARGV[0]
@data = []


#clear screen
def clear
system "cls"
end

#create new log file unless file exists
def mk_file
FileUtils.touch("c:/scripts/logs/#{@@file}.txt") unless File.exists?("c:/scripts/logs/#{@@file}.txt")
end

#get todays date and time
def date
@date = Time.now.strftime("%d/%m/%Y @ %H:%M")
puts @date
end

#user input into the journal
def user_input
puts "starts your entry into 'The #{@@file}' log and finish with [quit]"
puts "="*78
@data = []
while(a=STDIN.gets.chomp) !='quit'
@data.push(a)
end
end

#Write commandline entered data to the file.
def write2file
content  =<<"EOF"
\n===================================================================
#{@date}
===================================================================
#{@data.join("\n")}
EOF
puts content
File.open("c:/scripts/logs/#{@@file}.txt", 'a:UTF-8') { |file| file.write("#{content}") }
end


#The processing step
def start
clear
date
mk_file
user_input
write2file
end

#end of class
end

Journal.new.start

