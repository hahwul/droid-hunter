require File.dirname(__FILE__)+"/../config/config.rb"  #Include Config File
require 'open3'

def sscan(path,array)
 type=""
 pattern=""
 index=0 

 dicFile = File.open($p_sfilter).read
 dicFile.gsub!(/\r\n?/, "\n")
 dicFile.each_line do |fline|
 index = fline.index(":")
 type = fline[0..index-1]
 pattern = fline[index+1..-1]
 stdout, stdeerr, status = Open3.capture3($p_grep+" '"+pattern.strip!+"' "+path+" -i -R")
 array.push(stdout)
 end # file open
end

#test = Array.new()
#sscan("/home/noon/Noon/LAB/droid-hunter/1464576961_com.metasploit.stage/2_apktool/",test)
#puts test
