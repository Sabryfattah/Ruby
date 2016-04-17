files = Dir.glob("c:/test/*")
files.each do |f|
`c:/pdftotext.exe -raw  -nopgbrk #{f}` #unless File.exist?("#{f}\.txt")
end
