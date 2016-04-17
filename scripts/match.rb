# encoding: UTF-8
=begin
Features:
*List all your spending in one file, each item on a line, separated by commas
*Date, Venue, Category, Amount
*Caregories : Shopping, Food, Clothing, Home, Health, Outing, Bills
*Get a list of selected category saved into a file named (original-list_category.txt)
*Get the sum total of amount spent, appended to the end of that category list file
*Get a list of spending in a month saved to a file (original-list_month)
*Add the totals of each of the 12 months to get the annual spending

Script Steps:
1- read a file lines into an array 
2- search each line for regex matching pattern
3- list all lines which contain such pattern 
(with pattern highlighted between <>)
4- user to enter the name of file as first argument ARGV[0]
and pattern as second argument ARGV[1]
5- write all these pattern matching lines into a file with name of "pattern_rex.txt"
6- Append the sum total of amount spent to the end of the output file.

Usage:
search_file4 <original-list.txt> <category or month or regex pattern>

Output:
Files named original-list_category or original-list_month, (e.g. spent_march.txt)

Other uses:
1- Search a long list of database for items sharing the same pattern.
      e.g. Names of contacts living in the same city.
2- Search a long web page for ip addresses: http://
3- Search a number of files for lines containing a Regex pattern and save ouput to a file.
4- Sum any field containing amount of money in comma separated lines of data
5- Replacement for Excel sheets, manipulation of data in fields of lines in text file
6- Search a file for a pattern using commandline arguments (filename, search pattern)
=end


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


