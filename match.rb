# encoding: UTF-8
#Assign Variables and ARGV
@ary = []
@file = ARGV[0]
@pattern = ARGV[1]
# Read @file (ARGV[0]) into array @lines
@lines = File.readlines("c:\\scripts\\spending\\data\\#@file\.txt")

# match each line of array @lines and assign match data to @result
@lines.each do |line|
    /#@pattern/.match("#{line}")
    @result = "#{$`}<#{$&}>#{$'}" 
# Add result for each line to Array @ary, repeat for each line unless empty <>
    @ary << @result unless @result == "<>"
end

# Convert Array @ary to String separated by nil ""
text = @ary.join("")
# Write the string to a file named as @file_@pattern.txt
IO.write("c:\\scripts\\spending\\out\\#@file\_#@pattern\.txt", "#{text}")

# Sum the amount in last field of the new file @file_@pattern.txt
data = File.readlines("c:\\scripts\\spending\\out\\#@file\_#@pattern\.txt")

sum = 0
data.each do |line|
  field = line.split(",")
  num = field[3][2..-1]
  sum = sum +  num.to_f
end

# Append this Sum to the end of the total.txt
File.open("c:\\scripts\\spending\\out\\total\.txt", "a") {|f|
f.printf("%-60s%-1s%-20s", "\n Total of #@pattern", '£',"#{sum.round(2)}")
}


