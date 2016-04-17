class Rem

def self.usr_input
print "Enter Date:"
@date = gets.chomp
print "Enter Time:"
@time = gets.chomp
print "Enter Action:"
@action = gets.chomp
print "Enter Priority:"
@priority = gets.chomp
save_task
end

def self.save_task
open('./data/tasks.txt', 'a') {|f|
  f.print "#@date,#@time,#@action,#@priority\n"
}

end

def self.get_tasks
@tasks = []
File.open('./data/tasks.txt').each do |line|
  @tasks.push(line)
end
end

def self.print_tasks
clear
get_tasks
printf("%-5s%-15s%-10s%-40s%-10s", "No.","Date", "Time","Task","Priority")
Rem.separator
  @tasks.each_with_index do |line, index|
    array = "#{line}".split(",")
    printf("\n%-5d%-15s%-10s%-40s%-10s", "#{index+1}", "#{array[0]}", "#{array[1]}", "#{array[2]}", "#{array[3]}")
  end
end

def self.options
separator
puts "choose one of the following actions: "
print "l = list all tasks\nn = add new task\nd = delete task\ne = edit\nq = quit"
separator
choice = gets.chomp
  case choice 
    when 'l'  
	  print_tasks
    when 'n' 
	usr_input
	clear
	print_tasks
   when 'd'
     print "Enter task number to delete:"
	n = gets.chomp
	n = n.to_i
	task_delete(n)
	clear
	print_tasks
   when 'e'
     system"Notepad data/tasks.txt"
    when 'q'
	clear
	exit
  end
  options
end

def self.separator
print"\n==================================================================================\n"
end

def self.task_delete(x)
f = File.readlines("./data/tasks.txt")
n = x - 1
f.delete_at(n)
File.write('./data/tasks.txt', "", mode: 'w')
  f.each do |line|
    File.write('./data/tasks.txt', line, mode: 'a')
  end
end


def self.clear
system "cls"
end


end

Rem.options
Rem.save_task
