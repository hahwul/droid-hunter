#######################################################################
# simple3.rb
#
# Very plain HTML Table with rows and data implicitly created. This
# script passes an argument to the constructor, which is automatically
# interpreted as content.
#
# You can run this script via the "example:simple3" rake task.
#######################################################################
require 'html/table'
include HTML

m = [
  %w[foo bar baz],
  [1, 2, 3],
  %w[hello world]
]

table = Table.new(m)

puts table.html

# ### OUTPUT ###
# <table>
#    <tr>
#       <td>foo</td>
#       <td>bar</td>
#       <td>baz</td>
#    </tr>
#    <tr>
#       <td>1</td>
#       <td>2</td>
#       <td>3</td>
#    </tr>
#    <tr>
#       <td>hello</td>
#       <td>world</td>
#    </tr>
# </table>
