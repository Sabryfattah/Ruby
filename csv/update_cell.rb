require 'csv'

class UpCSV
#update csv by new values
def start 
puts "Enter filename"
@@file = STDIN.gets.chomp
puts "Enter Pattern in row to select"
@@pat  = STDIN.gets.chomp
@arr = []
@new_row = []
@selected_row = []
end

def read_csv
@table = CSV.read("c:/csv/#{@@file}\.csv", headers: true)
@headers = @table.headers
end

def select_row
@table.to_a.each_with_index do |row, index|
   row.select{|s| (@selected_row =  row) && (@indx = index-1)  if s =~ /#{@@pat}.*/}
end
end


def update_row
p @selected_row
@selected_row.each_with_index do |e, index|
  puts "#{e}"
  puts "Change '#{@headers[index]}' or keep it the same by 'ENTER' "
  new = STDIN.gets.chomp
  new = e unless new != ""
  @selected_row[index] =  new
end
p @selected_row
end

def userInterface
start
read_csv
select_row
puts "Selected Row: \n#{@select_row}"
update_row
puts "Altered Row : \n #{@arr}"
update_table
puts "Do you want to update file? (y/n)"
ans = STDIN.gets.chomp
if ans == "y"
 update_file
elsif ans == "n" 
 userInterface
else
  exit
end
  
end

def update_table
@table.delete(@indx)
@table.[]=(@indx, @selected_row)
puts "Altered Table : #{@table}"
end

def update_file
IO.copy_stream("c:/csv/#{@@file}.csv", "c:/csv/#{@@file}_2\.csv")
CSV.open("c:/csv/#{@@file}.csv", 'w') do |csv| # Create a new file updated_w.csv
  csv << @table.to_a[0]
  @table.each do |row|
      csv << row
  end
end
end

end

UpCSV.new.userInterface

