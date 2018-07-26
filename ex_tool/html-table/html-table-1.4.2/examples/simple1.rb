#######################################################################
# simple1.rb
#
# Very plain HTML Table with rows and data implicitly created.
#
# You can run this example via the "example:sample1" rake task.
#######################################################################
require 'html/table'
include HTML

table = Table.new do |t|
  t.content = [
    %w[foo bar baz],
    %w[1 2 3],
    %w[hello world]
  ]
end

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
