require "win32/clipboard"
include Win32

class SpeakClip

def speak
 puts "Enter 's' to speak or 'q' to quit"
 puts "="*87
 choice = gets.chomp
 case choice
  when  "s"
     system "start /min C:/Say/SayDynamic.exe #{Clipboard.data}"
  when  "q"
    exit
 end
end

end

SpeakClip.new.speak