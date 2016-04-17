require 'date' 

t = Time.now
day = t.wday
week ={
0 => "Sunday",
1 => "Monday",
2 => "Tuesday",
3 => "Wednesday",
4 => "Thursday",
5 => "Friday",
6 => "Saturday"
}

month = Date::MONTHNAMES[Date.today.month] 
p t.strftime("Today is #{week[day]} %d #{month} 20%y")