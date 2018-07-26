require File.dirname(__FILE__) + '/../config/config.rb' # Include Config File
require 'open3'

def sscan(path, array)
  type = ''
  pattern = ''
  index = 0

  puts ' --- Load pattern file'
  dicFile = File.open($p_sfilter).read
  dicFile.gsub!(/\r\n?/, "\n")
  puts ' --- Scan pattern'
  dicFile.each_line do |fline|
    index = fline.index(':')
    type = fline[0..index - 1]
    pattern = fline[index + 1..-1]
    stdout, stdeerr, status = Open3.capture3($p_grep + " '" + pattern.strip! + "' " + path + ' -i -R')
    unless stdout.empty?
      array[0].push(type)
      array[1].push(stdout)
    end
  end # file open
  puts ' --- End pattern scan'
end
