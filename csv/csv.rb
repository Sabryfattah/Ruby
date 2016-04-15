require 'csv'
require 'date' 

#=======================================
class CSV2

#=======================================
#commandline argument to get csv filename
@@path = "C:/scripts/APPS/csv/"
@@file = ARGV[0]

#=======================================
def userInterface
#user select which action to take
#options
puts  "="*78,"Enter your choice:
ac	:  Add header to the last column
ar	:  Adding new rows at bottom of file.
cv	:  Convert Text file to CSV file.
dc	:  Delete Column and its content
dr	:  Delete row by index or pattern
hd	:  Enter headers (first time)
og	:  Copy original csv file before starting to work on filet.
mr	:  Merge rows with same first column data into one row
so	:  Sort table by first column
r	:  Read csv file as a long list
sr	:  Display rows matching a pattern at first column
st	:  Sum Total of a Column of the table
uc	:  Change row cell and update file
uh	:  Update Header by Name or index
ut	:  Update table after changes.
","="*78


#user entries
choice = STDIN.gets.chomp
 case choice
  when "r"
    reader
  when "uh"
    update_header
  when "ar"
    writer
  when "og"
   copy_original
  when "hd"
    headers_entry
  when "sr"
    selector
  when "dc"
    delete_col
  when "ut"
    update_table
  when "dr"
   delete_row
  when "mr"
    merge_rows
  when "so"
    sort_csv
  when "ac"
    add_col
  when "st"
   sumTotal
  when "uc"
    update_cell
  when "cv"
    txt2csv
 end
 #end of user interface
end

#=========================================
#initialize new csv file by entering headers
def headers_entry
puts "Enter Headers separated by spaces"
@@headers = gets.chomp.split(" ")
CSV.open("#{@@path}#{@@file}\.csv", "w") do |csv|
   csv << @@headers
end
end

#=========================================
#Adding more rows at the bottom of csv file which has headers.
def writer
table = CSV.read("#{@@path}#{@@file}\.csv", headers: true)
@@headers = table.headers()
begin
	print "Enter #{@@headers[0]}:  \n -"
	d1 = STDIN.gets.chomp
	print "Enter #{@@headers[1]}:  \n -"
	d2 = STDIN.gets.chomp
	print "Enter #{@@headers[2]}:  \n -"
	d3 = STDIN.gets.chomp
	print "Enter #{@@headers[3]}:  \n -"
	d4 = STDIN.gets.chomp
	print "Enter #{@@headers[4]}:  \n -"
	d5 = STDIN.gets.chomp
	print "Enter #{@@headers[5]}:  \n -"
	d6 = STDIN.gets.chomp
	@@rows = ["#{d1}", "#{d2}", "#{d3}", "#{d4}", "#{d5}", "#{d6}"]
	CSV.open("#{@@path}#{@@file}\.csv", 'a') do |csv|
       csv << @@rows
    end
	print "Do you want to add more ? (y/n): "
	ans = STDIN.gets.chomp
end while ans != "n"
#end of adding new rows at bottom
end

#========================================
# read all csv file as a long list
def reader
table = CSV.read("#{@@path}#{@@file}\.csv", headers: true)
@@headers = table.headers().to_a
puts "Details of #{@@file}"
puts "-"*141
printf("%-20s%-2s%-20s%-2s%-20s%-2s%-20s%-2s%-20s%-2s%-20s%-4s", 
"#{@@headers[0]}" ,"|", "#{@@headers[1]}", "|", "#{@@headers[2]}" ,"|", "#{@@headers[3]}" ,"|", "#{@@headers[4]}" ,"|","#{@@headers[5]}", "|")
puts ""
puts "-"*141
CSV.foreach("C:/scripts/APPS/csv/#{@@file}\.csv", headers: true) do |row|
	printf("%-20s%-2s%-20s%-2s%-20s%-2s%-20s%-2s%-20s%-2s%-20s%-4s", "#{row[0]}",  "|", "#{row[1]}", "|","#{row[2]}", "|","#{row[3]}", "|","#{row[4]}", "|","#{row[5]}", "|")	
	puts ""
end
puts ""
#end of reading the full csv file as a list
end

#======================================
#Display selected rows matching a pattern at first column
def selector
puts "Select records matching a pattern in any column"
@table = CSV.read("#{@@path}#{@@file}\.csv", headers: true)
@table.headers.each_with_index{|h, i| puts "#{i}....#{h}"}
puts "Enter index of column to search"
index = STDIN.gets.to_i
puts "Enter Pattern in column\n"
pat = STDIN.gets.chomp
@table = CSV.read("#{@@path}#{@@file}\.csv", headers: true)
@rows = []
@table.each do |row|
 @rows << row if row[index] =~ /#{pat}/i
end
@@headers = @table.headers().to_a
puts "Details from #{@@file}"
puts "-"*141
printf("%-20s%-2s%-20s%-2s%-20s%-2s%-20s%-2s%-20s%-2s%-20s%-4s", 
"#{@@headers[0]}" ,"|", "#{@@headers[1]}", "|", "#{@@headers[2]}" ,"|", "#{@@headers[3]}" ,"|", "#{@@headers[4]}" ,"|","#{@@headers[5]}", "|")
puts ""
puts "-"*141
@rows.each do |row|
	printf("%-20s%-2s%-20s%-2s%-20s%-2s%-20s%-2s%-20s%-2s%-20s%-4s", "#{row[0]}",  "|", "#{row[1]}", "|","#{row[2]}", "|","#{row[3]}", "|","#{row[4]}", "|","#{row[5]}", "|")	
puts ""
end
#end of display rows matching a pattern
end

#======================================
# copy original csv file before manipulating it
def copy_original
IO.copy_stream("#{@@path}#{@@file}\.csv", "#{@@path}#{@@file}_original\.csv")
puts "original csv file copied to file_original.csv"
end

#========================================
#delete a column and all its content selected by header
def delete_col
@table = CSV.read("#{@@path}#{@@file}\.csv", headers: true)
@@headers = @table.headers().to_a
p @@headers
puts "Enter column header to delete"
hd = STDIN.gets.chomp
@table.delete("#{hd}")
update_table
end

#==============================================
#update csv table by re-writing the modified content to it.
def update_table
CSV.open("#{@@path}#{@@file}\.csv", 'w') do |csv|
  csv << @table.to_a[0]
  @table.each do |row|
      csv << row
  end
end
end

#==========================================
#delete a row by pattern at a column and update table
def delete_row
@table = CSV.read("#{@@path}#{@@file}\.csv", headers: true)
puts "Enter Header"
hdr = STDIN.gets.chomp
puts "Enter pattern"
pat = STDIN.gets.chomp
@table =@table.delete_if do |row|
  row["#{hdr}"] =~ /#{pat}/
end
update_table
#end of delete_row
end

#==============================================
#sort table by first field
def sort_csv
#read table 
@table = CSV.read("#{@@path}#{@@file}\.csv", headers: true)
#sort by first field
@new_table = @table.to_a.sort! { |a, b| a.first.downcase <=> b.first.downcase}
#remove duplicates
#@table.to_a.uniq!(&:first)
#get headers
@@headers = @table.headers()
#open file for writing
  CSV.open("#{@@path}#{@@file}\.csv", 'w') do |csv|
      csv << @@headers
      @new_table.each do |row|
          csv << row unless row == @@headers
       end
    end
end

#=========================================
def add_col
@table = CSV.read("#{@@path}#{@@file}\.csv", headers: true)
puts "Enter name of Header of new column"
hd = STDIN.gets.chomp
CSV.open("#{@@path}#{@@file}\.csv", 'w') do |csv|
       csv << @table.headers+["#{hd}"]
      @table.each do |row|
          csv << row
       end
end
end

#==============================================
#sum the total of a column in the table
def sumTotal
puts "Enter Header"
@hdr = STDIN.gets.chomp
table = CSV.read("#{@@path}#{@@file}\.csv", headers: true, :converters => :numeric)
nn = table.by_col["#{@hdr}"]
puts "Total for Column #{@hdr} :-", "="*78
total =  nn.inject(:+).round(2)
puts total
 "="*78
file = File.open("c:/scripts/APPS/csv/assets.txt", "a")
file.puts "Total Savings on #{Time.now.strftime("%d/%m/%y")} =                    #{total} Pounds"
end

#============================================
def update_cell
table = CSV.read("#{@@path}#{@@file}\.csv", :headers => true)
reader
begin
	puts "Enter header of a column with unique data at selected row"
	selected_header = STDIN.gets.chomp
	puts "Enter regex or content in #{selected_header} at selected row"
	pat = STDIN.gets.chomp
	puts "Enter Header of Column to change"
	target_header = STDIN.gets.chomp
	puts "Enter new value to change at #{target_header} column"
	new_value = STDIN.gets.chomp
	new_table = []
	table.each do|row|
		row["#{target_header}"] = "#{new_value}" if row["#{selected_header}"] =~ /#{pat}/i
		new_table << row
	end
	print "Do you want to update more cells ? (y/n): "
	ans = STDIN.gets.chomp
end while ans != "n"
reader
CSV.open("#{@@path}#{@@file}\.csv", 'w') do |csv| # Create a new file updated_w.csv
  csv << table.headers # Add new headers
  new_table.each do |row|
    csv.puts row  #puts into the new file the rows from new_table
  end
end
reader
end

#============================================
def merge_rows
puts "Enter pattern in first column"
pat = STDIN.gets.chomp
table = []
#get a table of all file including headers
CSV.foreach("#{@@path}#{@@file}\.csv") do |row|
  table << row
end
#get headers
 @headers = table[0]
# and rows array
  rows = table[1..-1]
 group = []
 #get row including pattern and add it to group array
 rows.each do |row|
    group << row if row[0] =~ /#{pat}/
 end
#remove duplicate from group array
  new = group.flatten.uniq
  new_rows = []
# create a new row without duplicate first column
  new_rows = rows.delete_if{|i|i[0]=~ /#{pat}/}
# Add group array and array rows without duplicate to new_table
  new_table = new_rows << new
#Write updated table to a same file
CSV.open("#{@@path}#{@@file}\.csv", 'w') do |csv|
  csv.puts @headers
  new_table.each do |row|
    csv.puts row
  end
end
sort_csv
end

#===============================================
def update_header
#get a table from csv file with headers
table = CSV.read("#{@@path}#{@@file}\.csv", :headers => true)
# Assign headers to @hds variable
@hds = table.headers
#begin 'to continue' loop
begin
# user entry of header name and new header
	puts "Change header by name 'n' or index 'i' ?"
	choice = STDIN.gets.chomp
	case choice
		when "n"
			puts "Enter header name to change"
			@selected_header = STDIN.gets.chomp
			# get index of selected_header
			@indx = @hds.index("#{@selected_header }")
			puts "Enter new header for column : #{@selected_header }"
			@new_header = STDIN.gets.chomp
			@hds[@indx] = @new_header
		when "i"
			puts "Enter Index of column from left if not header"
			@index = STDIN.gets.to_i
			puts "Enter new header for column number #{@index+1}"
			@new_header = STDIN.gets.chomp
			@hds[@index] = @new_header
	end
# create a new array for the table
	@new_table = []
#Add the rows to the table
	table.each do|row|
		@new_table << row
	end
# Ask to continue
	print "Do you want to update more headers ? (y/n): "
	ans = STDIN.gets.chomp
end while ans != "n"
# check the file
reader
# write the new table to file
CSV.open("#{@@path}#{@@file}\.csv", 'w') do |csv| # Create a new file updated_w.csv
  csv << @hds # Add new headers
  @new_table.each do |row|
    csv.puts row  #puts into the new file the rows from new_table
  end
end
reader
end

#============================================
def txt2csv
	puts "Enter text file name with extension"
	@file = STDIN.gets.chomp
	puts "Enter Path "
	@default =  'c:/scripts/APPS/csv/'
	@path == STDIN.gets.chomp unless @path == ""
		@path = @default 
	string = IO.read("#{@path}#{@file}")
	table = CSV.parse(string, :headers => true,  :skip_blanks => true)
#Write updated table to a new file
	CSV.open("c:/scripts/APPS/csv/#{@file}", 'w') do |csv|
		csv << table.headers
		table.each do |row|
			csv.puts row
		end
	end

end

#============================================
#end of class
end

#start class use
CSV2.new.userInterface