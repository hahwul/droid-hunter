require 'html/table'
include HTML

def str_point(app_pointer)
 formdata = "<table>"
 i=0
 ary = app_pointer.getstrlist_addr
 len = ary[0].length
 while(i<len)
  formdata += "<tr><td>"+ary[0][i]+"</td>"
  formdata += "<td>"+ary[1][i]+"</td></tr>"
  i+=1
 end
 formdata += "</table>"
 return formdata
end

def generate_report(app_pointer)
 report_html=""
 workspace = app_pointer.getworkspace
 report=[["App.Package",app_pointer.getpackage],
["App.File_path",app_pointer.getfile],
["App.Main",app_pointer.getmain],
["App.Permission",app_pointer.getperm.gsub("android.", '<br>android.')],
["App.Decompile","<table>
<tr>
 <td>UNZIP: Analysis of native code, resources , etc.</td><td><a href='file:#{workspace}/1_unzip/' target='_blank' style='color: red'>go link</a></td>
</tr>
<tr>
 <td>SMALI CODE: View source code viewer</td><td><a href='file:#{workspace}/2_apktool/' target='_blank' style='color: red'>go link</a></td>
</tr>
<tr>
 <td>JAR CLASS: View jd-gui</td><td><a href='file:#{workspace}/3_dex2jar/' target='_blank' style='color: red'>go link</a></td>
</tr>
<tr>
 <td>JAVA CODE: View source code viewer</td><td><a href='file:#{workspace}/4_jad/' target='_blank' style='color: red'>go link</a></td>
</tr>
</table>"],
["App.Str_point",str_point(app_pointer)]
]
 table=Table.new(report)
 table_html = table.html #puts table.html
 
 f = File.open(File.dirname(__FILE__)+"/../template/report_template.html","r")
 report_html = f.read()
 report_html.insert(report_html.index("<!-- {report} -->")+24,table_html)   # ^ is checking string 
# puts report_html
 wf = File.open(app_pointer.getdirectory+".html","w")
 wf.puts report_html
 wf.close
end

