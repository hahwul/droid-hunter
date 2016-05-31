require File.dirname(__FILE__)+"/config/config.rb"  #Include Config File
require File.dirname(__FILE__)+"/src/sscan.rb"  #Include Scan
require File.dirname(__FILE__)+"/src/generate_report.rb"  #Include Report

def banner()
puts "Droid::Hunter"
puts "Code by hawul"
puts "================================="
end

def help()
  puts "Usage: ruby dhunter.rb [APK]"
  puts "   => dhunter 123.apk"
  puts "   => dhunter 123.apk aaa.apk test.apk hwul.apk"
  puts "Runable"
  puts "   1. Unzip apk"
  puts "   2. Smali code decompile apk"
  puts "   3. Dex2jar decompile apk"
  puts "   4. Java code decompile apk"
end
# ==================================================
class App
 def initialize(file)
   @app_file = file
   @app_perm = ""
   @app_feature = ""
   @app_main = ""
   @app_package = "" 
   @app_workspace = ""
   @app_strlist = Array.new(2)
   for i in (0..2)
     @app_strlist[i] = Array.new()
   end
 end
 def scan_info()  #Scanning App default information
   IO.popen($p_aapt+" dump badging "+@app_file, 'r') do |pipe|
   pipe.each_line do |line|
     if line.include? "package: name="
       @app_package = line[14..-1]
       @app_package = @app_package[0..@app_package.index(" ")]
       @app_package = @app_package.delete("'")
     else if line.include? "uses-permission:"
       @app_perm += line[16..-1]
       @app_perm = @app_perm.delete("'")
     else if line.include? "launchable-activity: name="
       @app_main = line[26..-1]
       @app_main = @app_main[0..@app_main.index(" ")]
       @app_main = @app_main.delete("'")
     end
     end
     end
   end
   end
   time = Time.new
   @app_workspace = Dir.pwd+"/"+(time.to_i).to_s+"_"+@app_package
   @app_workspace = @app_workspace.strip!
   @app_time = (time.to_i).to_s
 end
 def make_work() # Mkdir + Apk Decompile + BakSmiling
   Dir.mkdir(@app_workspace)
   system("cp "+@app_file+" "+@app_workspace+"/"+@app_time+"_"+@app_package.strip+".apk")
   Dir.chdir(@app_workspace)
   @app_file = Dir.pwd+"/"+@app_time+"_"+@app_package.strip+".apk"
   system($p_unzip+" "+@app_file+" -d "+@app_workspace+"/1_unzip/")  ## Unzip
   system("java -jar "+$p_apktool+" d "+@app_file+" "+@app_workspace+"/2_apktool/")  ## apktool
   system($p_dex2jar+" "+@app_file)  ## dex2jar
   system($p_unzip+" "+@app_workspace+"/"+@app_time+"_"+@app_package.strip+"_dex2jar.jar"+" -d "+@app_workspace+"/3_dex2jar/")  ## Unzip
   system($p_jad+" -o -r -sjava -d"+@app_workspace+"/4_jad/ 3_dex2jar/**/*.class")  ## dex2jar
   puts $p_jad+" -o -r -sjava -d"+@app_workspace+"/4_jad/ "+@app_workspace+"3_dex2jar/**/*.class"
# jad -o -r -sjava -d./4_jad 3_dex2jar/**/*.class
 end
 def returnFile()
   puts @app_file
   puts @app_package
   puts @app_perm
   puts @app_main
   puts @app_workspace
 end
 def getdirectory()
   return @app_time + "_" + @app_package.strip
 end
 def getperm()
   return @app_perm
 end
 def getmain()
   return @app_main
 end
 def getfile()
   return @app_file
 end
 def getpackage()
   return @app_package
 end
 def getworkspace()
   return @app_workspace
 end
 def getstrlist_addr()
   return @app_strlist
 end
 def test()
   puts @app_strlist
 end
end
# ==================================================
banner()
if(ARGV.size == 0)
  help()
  exit()
else if(ARGV[0] == "-h" or ARGV[0] == "--help")
  help()
  exit()
else
  i=0
  app = Array.new
  while(i<ARGV.size)
    app.push(App.new(ARGV[0]))
    i+=1
  end
  i=0
  while(i<ARGV.size)
    app[i].scan_info() # Scan App Default Info
    app[i].returnFile()
    app[i].make_work() # Decompile + Unzip
    sscan(app[i].getworkspace+"/2_apktool/",app[i].getstrlist_addr()) # Scan smali code
    sscan(app[i].getworkspace+"/4_jad/",app[i].getstrlist_addr()) # Scan java code
    Dir.chdir("../")
    generate_report(app[i])
    puts "[FINISH] :: "+app[i].getpackage()
    i+=1
  end
end
end








