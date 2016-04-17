class Go
@list = File.readlines('./data/files.txt').map{ |line| line.split(',') }

def self.list_files
system "cls"
print"==============================================================================\n"
print "                      My Ruby Scripts  Documentation                   \n"
print "==============================================================================\n"
  @list.each_with_index do |e, index|
    printf("%-5d%-10s%-10s","#{index}", "#{e[0]}", "#{e[1]}")
	#, "#{e[2]}", "#{e[3]}")
  end
   get_usr_input
end

def self.get_usr_input
print"\n==============================================================================\n"
print "To read documentation of a script select corresponding number or 'q' to quit    \n"
print "==============================================================================\n"
  print "> "
  choice = gets.chomp
  file = @list[choice.to_i][0]
  unless choice == 'q'
      system "cls"
      #system %{cmd /c "ruby #{file}\.rb"}
	 system %{cmd /c "start c:\\scripts\\docs\\#{file}\.txt"}
	print "\n==============================================================================\n"
	 print "\n[Press Any key to continue........................] \n"
	 gets
	 list_files
  else
     system "cls"
      exit
  end
end


end

system "cls"
Go.list_files