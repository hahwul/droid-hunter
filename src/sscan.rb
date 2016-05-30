require File.dirname(__FILE__)+"/../config/config.rb"  #Include Config File
require 'open3'

def sscan(path,array)
 dicFile = File.open($p_sfilter).read
 dicFile.gsub!(/\r\n?/, "\n")
 dicFile.each_line do |fline|
 stdout, stdeerr, status = Open3.capture3($p_grep+" '"+fline.strip!+"' "+path+" -i -R")
 array.push(stdout)
 end # file open
end

#test = Array.new()
#sscan("/home/noon/Noon/LAB/droid-hunter/1464576961_com.metasploit.stage/2_apktool/",test)
#puts test
