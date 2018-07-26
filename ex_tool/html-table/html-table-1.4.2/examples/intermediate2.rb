##############################################################################
# intermediate2.rb
#
# A slightly more advanced HTML Table.  This time we'll add some attributes,
# add a few rows both implicitly and explicitly, then configure it
# after-the-fact.  We'll also play with Captions and Headers and generally
# do things slightly different that intermdiate1.rb.
#
# You can run this via the "example:intermediate2" rake task.
##############################################################################
require 'html/table'
include HTML

table = Table.new
table.border = 1
table.cellpadding = 5

caption = Table::Caption.new
caption.content = 'This is a caption!'

row1 = Table::Row.new
row2 = Table::Row.new

row1.bgcolor = 'red'
row2.bgcolor = 'blue'

d1 = Table::Row::Data.new { |d| d.content = 'foo' }
d2 = Table::Row::Data.new { |d| d.content = 'bar' }
d3 = Table::Row::Data.new { |d| d.content = 'baz' }

row1[0..2] = d1, d2, d3

d4 = Table::Row::Data.new { |d| d.content = 'hello' }
d5 = Table::Row::Data.new { |d| d.content = 'world' }

h1 = Table::Row::Header.new
h1.content = 'This is a header'
h1.colspan = 2

row2.unshift h1
row2.push d4, d5

table.push row1, row2
table.push caption # automatically bumped to row 0

puts table.html

# <table border=1 cellpadding=5>
#    <caption>This is a caption!</caption>
#    <tr bgcolor='red'>
#       <td>foo</td>
#       <td>bar</td>
#       <td>baz</td>
#    </tr>
#    <tr bgcolor='blue'>
#       <th colspan=2>This is a header</th>
#       <td>hello</td>
#       <td>world</td>
#    </tr>
# </table>
