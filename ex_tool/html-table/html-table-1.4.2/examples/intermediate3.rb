#######################################################################
# intermediate3.rb
#
# This example demonstrates some intermediate features, including the
# DSL style syntax and physical tag handling.
#
# You can run this example via the "example:intermediate3" rake task.
#######################################################################
require 'html/table'
include HTML

# You can set physical tags inline using block syntax...
table = Table.new do
  align 'left'
  bgcolor  'red'
  header   [%w[header1 header2]]
  content  [%w[foo bar]]
  content  [%w[baz blah]] do
    underline true
    tt true
  end
end

# Or you can do it this way
table[1][0].content.bold   = true
table[1][1].content.italic = true

puts table.html

# ### OUTPUT ###
# <table align='left' bgcolor='red'>
#    <tr>
#       <th>header1</th>
#       <th>header2</th>
#    </tr>
#    <tr>
#       <td><b>foo</b></td>
#       <td><i>bar</i></td>
#    </tr>
#    <tr>
#       <td><tt><u>baz</u></tt></td>
#       <td><tt><u>blah</u></tt></td>
#    </tr>
# </table>
