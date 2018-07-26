##############################################################################
# intermediate1.rb
#
# A slightly more advanced HTML Table.  This time we'll add some attributes,
# add a few rows both implicitly and explicitly, then configure it
# after-the-fact.
#
# You can run this via the "example:intermediate1" rake task.
##############################################################################
require 'html/table'
include HTML

# Create a table, add two rows implicitly
table = Table.new do |t|
  t.border  = 1
  t.align   = 'left'
  t.content = [
    %w[foo bar baz],
    [1, 2]
  ]
end

# Create a Table::Row object with one Data object added implicitly
row1 = Table::Row.new do |r|
  r.bgcolor = 'red'
  r.nowrap = true
  r.content = 'test'
end

# Create a Table::Row object, add a Data object explicitly (with some
# configuration to boot)
row2 = Table::Row.new do |r|
  r.bgcolor = 'blue'
  r.align = 'right'
  r.content = Table::Row::Data.new { |d|
    d.content = 'hello world!'
    d.abbr = 'test abbr'
  }
end

# Add the rows explicitly to the table
table.push row1, row2

# Let's configure the row that contains "foo","bar","baz"
# Remember, row and column counts start at 0, not 1
table.configure(0) do |r|
  r.bgcolor = 'green'
  r.align = 'right'
end

puts table.html

# ### OUTPUT ###
# <table border=1 align='left'>
#    <tr bgcolor='green' align='right'>
#       <td>foo</td>
#       <td>bar</td>
#       <td>baz</td>
#    </tr>
#    <tr>
#       <td>1</td>
#       <td>2</td>
#    </tr>
#    <tr bgcolor='red' nowrap>
#       <td>test</td>
#    </tr>
#    <tr bgcolor='blue' align='right'>
#       <td abbr='test abbr'>hello world!</td>
#    </tr>
# </table>
