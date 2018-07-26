#######################################################################
# simple2.rb
#
# Very plain HTML Table with rows explicitly created and data
# elements implicitly created. We also remove the end tags
# and capitalize the HTML tags and attributes.
#
# You can run this sample via the "example:simple2" rake task.
#######################################################################
require 'html/table'
include HTML

Table.html_case = 'upper'
Table::Row.end_tags = false
Table::Row::Data.end_tags = false

table = Table.new
tr1 = Table::Row.new
tr2 = Table::Row.new
tr3 = Table::Row.new

tr1.content = 'foo', 'bar', 'baz'
tr2.content = 1, 2, 3
tr3.content = %w[hello world]

table.push(tr1, tr2, tr3)

table[0][1].align = 'left'

puts table.html

# ### OUTPUT ###
# <TABLE>
#    <TR>
#       <TD>foo
#       <TD ALIGN='LEFT'>bar
#       <TD>baz
#    <TR>
#       <TD>1
#       <TD>2
#       <TD>3
#    <TR>
#       <TD>hello
#       <TD>world
# </TABLE>
