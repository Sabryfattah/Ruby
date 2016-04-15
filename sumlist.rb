class Accounts

def start
puts "="*87
puts "This script extract a list from a mega list in a text file and display\nthe sum of total values in last column. Each line of mega list contains values separated by\ncommas, e.g. Date, Venu, category, Amount.\nTo sum eveything in the list, enter [A-Za_z]"
puts "-"*87
puts "Enter Categories separated by spaces"
cats = gets.chomp
@@categories = cats.split(" ")
puts "Enter file name without extension"
@@file = gets.chomp
#@@months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
Accounts.new.listCat
#Accounts.new.listMo
#system "ruby barc.rb >> c:/report.txt 2>&1"
end

def listCat
@@categories.each{|c| sum_category(c)}
end

def listMo
@@months.each{|c| sum_category(c)}
end

def sum_category(cat)
lines = IO.readlines("#{@@file}\.txt")
selection, amount = [] , []
lines.each do |line|
 selectedLine =  line if line =~ /\s#{cat}/i
 selection << selectedLine unless selectedLine == nil
 amount <<  selectedLine.split(",")[-1].to_f unless selectedLine == nil
end
puts "Details for #{cat} category"
puts "="*87
puts selection
puts "="*87, 
"TOTAL                          #{amount.inject(:+).round(2)}\n"
puts "="*87
end

end

Accounts.new.start