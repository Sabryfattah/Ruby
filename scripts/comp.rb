#Calculate compound interest of amount invested for a number of years
#User enter the Principal Amount, Number of years, Annual interest Rate as a float
# e.g. 0.05 is 5%
#Times compounded each year, e.g. 1 Annually, 4 Quarterly, 12 monthly
# The result is printed to the screen
class Compound

def usr_input
values = []
entries = {
"Enter Prinicpal Amount: " => values[0],
"Enter Annual Interest Rate Rate as Float:"  =>values[1],
"Enter Number of Years: " => values[2],
"Enter Times Compounded each year (1 = annually, 12 = monthly):" => values[3]
}
entries.each do |k,v|
		puts "#{k}"
		v = gets.to_f
		values << v
end
compound_interest(values[0], values[1], values[2], values[3])
end


def compound_interest(p, r, t, n)
	result = p * (1 + r/n) ** (n*t)
	interest = result.round
	puts "Return of compound interest is #{interest}"
end

end

c = Compound.new
c.usr_input