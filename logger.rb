@@intro = <<EOS
Enter daily entries into a Journal, each entry is dated with
today's date and time of writing. The user continues writing the
entry until "quit" is typed which finishes the entry and add it to
the Journal file. The file is saved into the directory
c:/scripts/logs/"directory"which is created if it does not exist. If
the file and directory exists, the entries are added sequentially to
the file separated by ==== separator.
default filename is "Journal.txt". You can build as many logs as
you wish.
EOS

def user_entry
@@logs = []
puts "="*87
puts @@intro.center(20)
puts "="*87
puts "Select a log to add to:"
@folders = Dir.glob('c:/scripts/logs/*').select {|f| File.file? f}
@folders.each do |f|
  @@logs <<  File.basename(f, "rb")
end
@folders.each_with_index do |d, index|
  puts "#{index+1}..#{File.basename("#{d}", "rb")}"
 end
 puts "="*87
 puts "Select log number\nOtherwise, Enter 'n' for new log or 'o' to open log>>"
 log = gets.chomp
 p log
case log
  when "1"
     system("ruby c:/scripts/log.rb")
  when "2"
     system("ruby c:/scripts/log.rb #{@@logs[1]}")
  when "3"
    system("ruby c:/scripts/log.rb #{@@logs[2]}")
  when "4"
     system("ruby c:/scripts/log.rb #{@@logs[3]}")
   when "5"
     system("ruby c:/scripts/log.rb #{@@logs[4]}")
   when "n"
    puts "Enter log filename:\n>>"
     fn = gets.chomp
     system("ruby c:/scripts/log.rb #{fn}")
   when "o"
     puts "Enter log file to open:\n>>"
	fo = gets.chomp
     system("Notepad c:/scripts/logs/#{fo}\.txt")
end

end

user_entry