require "win32/clipboard"
include Win32

system "start /min C:/Say/SayDynamic.exe #{Clipboard.data}"
