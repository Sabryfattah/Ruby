# encoding: UTF-8

class Spending
@@mos = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
@@cats = ["Shopping", "Outing", "Home", "Car", "clothing", "food", "health", "cash"]

@@intro =<<EOS
#{' Spending Lists '.center(87, "=")} 
This script extracts data from master list file at
'c:/scripts/spending/data' directory for a pattern (month,
category) and write extracted data to files in the
'c:/scripts/spending/out' directory. The sum total of amount
spent during a certain month or a category is appended to the
'total.txt' file in ''c:/scripts/spending/out' directory.The totals of
the 12 months gives the  annual spending for the year or
categories.
EOS

def userEntry
puts @@intro
puts "="*87
#Assign Variables
@extracted = []
puts "Enter the name of the Master_file, e.g. 2015"
@Master_file = gets.chomp
puts "Enter the chosen month (e.g. Feb) or category (e.g. Cash) or any pattern"
@@pattern = gets.chomp
end

def read_Master
# Read @Master_file  into array @lines
@@lines = File.readlines("c:\\scripts\\spending\\data\\#@Master_file\.txt")
end

def extract_Lines(pattern)
# match each line of array @lines and assign match data to @result
@extracted.clear
puts "#{pattern}".center(80)
puts "="*87
@@lines.each do |line|
     /#{pattern}/i.match("#{line}")
    @result = "#{$`}<#{$&}>#{$'}"
# Add result for each line to Array @ary, repeat for each line unless empty <>
    @extracted <<  @result unless @result == "<>"
end
return @extracted
end

def write_Extracted(pattern)
# Convert Array @extracted  to String separated by nil ""
text = @extracted.join("")
# Write the string to a file named as @file_@pattern.txt
IO.write("c:\\scripts\\spending\\out\\#{pattern}\_#@Master_file\.txt", "#{text}")
end

def sum_extracted(pattern)
# Sum the amount in last field of the new file @file_@pattern.txt
data = File.readlines("c:\\scripts\\spending\\out\\#{pattern}\_#@Master_file\.txt")
@@sum = 0
data.each do |line|
    /\d{1,4}\.\d{2}|\d{1,4}$/.match("#{line}")
   @value = "#{$&}"
   @@sum += @value.to_f
end
return @@sum.round(2)
end

def append_sum(pattern)
# Append this Sum to the end of the total.txt
File.open("c:\\scripts\\spending\\out\\total\.txt", "a") {|f|
f.printf("%-60s%-1s%-20s", "Total of #{pattern}", '#',"#{@@sum.round(2)}\n")
}
end

def getSumTotal(pattern)
@@totals = []
@@total = []
totals = File.readlines("c:\\scripts\\spending\\out\\total\.txt")
totals.each do |line|
 @@total << "#{line.split('#', 2)[1]}".to_f
end
puts "-"*87
puts "Total for #{pattern} spending......................................#{@@total[-2]}"
@t =  @@total.inject(:+)
puts "="*87
  puts "Grand Total ................................................#{@t.round(2)}"
puts "-"*87
end

def go(selection)
f = "c:\\scripts\\spending\\out\\total\.txt"
if File.exists?(f)
File.delete(f)
end
userEntry
read_Master
selection.each do |m| 
 puts  extract_Lines("#{m}")
 write_Extracted("#{m}")
 sum_extracted("#{m}")
 append_sum("#{m}")
 getSumTotal("#{m}")
end

end

def select
puts "Select matching pattern:\n1. Months\n2.Categories"
sel = gets.chomp
case sel
 when "1"
  go(@@mos)
 when "2"
  go(@@cats)
end
end

end

Spending.new.select

