class Rewrite

 def self.wrap(s, width=85)
	  s.gsub(/(.{1,#{width}})(\s+|\Z)/, "\\1\n")
 end

 def self.list_dir
    #get list of files in the selected directory
    @files = Dir.glob("c:/rd/*.txt")
  end

 def self.file_change
    list_dir
	@files.each do |f|
	   file = []
	   text = File.read("#{f}")
	   ary = text.split("=====")
	     ary.each do |p| 
	       p.gsub!("==>", "\n#{'-'*85}") 
	       file << "#{p}\n\n"
	     end
      text = file.join("")
      File.write("#{f}", text)
    end
 
end

end
Rewrite.file_change

