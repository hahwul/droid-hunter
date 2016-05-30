require 'html/table'
include HTML
report=[["Customer1",2042.3],["Customer2",12345.6],["Customer3",4711.0]]
table=Table.new(report)
# puts table.html

=begin <table>
   <tr>
      <td>Customer1</td>
      <td>2042.3</td>
   </tr>
   <tr>
      <td>Customer2</td>
      <td>12345.6</td>
   </tr>
   <tr>
      <td>Customer3</td>
      <td>4711.0</td>
   </tr>
</table>
=end
