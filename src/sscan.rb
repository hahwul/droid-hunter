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
 if(stdout.size !=0)
 array[0].push(type)
 array[1].push(stdout)
 end
 end # file open
end

