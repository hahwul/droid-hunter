##############################################################################
# advanced1.rb
#
# For this example we'll use every feature I can think of to come up with
# the example found in "HTML: The Definitive Guide", pp. 395-396 (O'Reilly
# & Associates, 3rd ed).
#
# You can run this example via the 'example:advanced' rake task.
##############################################################################
require 'html/table'
include HTML

Table::Row::Data.end_tags   = false
Table::Row::Header.end_tags = false

# Demonstrates the DSL style syntax
table = Table.new do
  border      1
  cellspacing 0
  cellpadding 0
  rules       'groups'
end

# Demonstrates the use of setters after object creation
caption = Table::Caption.new
caption.align = 'bottom'
caption.content = 'Kumquat versus a poked eye, by gender'

thead = Table::Head.create
tbody = Table::Body.new
tfoot = Table::Foot.create

# Add a row with a td and th, then configure after the fact.
thead.push Table::Row.new { |r|
  r.content = Table::Row::Data.new, Table::Row::Header.new
}

# And again, longhand
hrow = Table::Row.new
h1 = Table::Row::Header.new('Eating Kumquats')
h2 = Table::Row::Header.new('Poke In The Eye')
hrow.push h1, h2
thead.push hrow

# Configure a row after the fact
thead.configure(0, 0) do |d|
  d.colspan = 2
  d.rowspan = 2
end

thead.configure(0, 1) do |h|
  h.colspan = 2
  h.align   = 'center'
  h.content = 'Preference'
end

# Ugly, but just to show you that it's possible
tbody.push(
  Table::Row.new do |r|
    r.align = 'center'
    r.content =
      Table::Row::Header.new do |h|
        h.rowspan = 2
        h.content = 'Gender'
      end,
      Table::Row::Header.new { |h| h.content = 'Male' },
      '73%',
      '27%'
  end
)

brow = Table::Row.new { |r| r.align = 'center' }
bheader = Table::Row::Header.new('Female')
brow.push(bheader, '16%', '84%')

tbody.push(brow)

frow = Table::Row.new do |r|
  r.content = Table::Row::Data.new { |d|
    d.colspan = 4
    d.align   = 'center'
    d.content = 'Note: eye pokes did not result in permanent injury'
  }
end

tfoot[0] = frow

table.push thead, tbody, tfoot

# caption is added last, but does the right thing
table.push caption

puts table.html

# ### OUTPUT ###
# <table border=1 cellspacing=0 cellpadding=0 rules='groups'>
#    <caption align='bottom'>Kumquat versus a poked eye, by gender</caption>
#    <thead>
#    <tr>
#       <td colspan=2 rowspan=2>
#       <th colspan=2 align='center'>Preference
#    </tr>
#    <tr>
#       <th>Eating Kumquats
#       <th>Poke In The Eye
#    </tr>
#    </thead>
#    <tbody>
#    <tr align='center'>
#       <th rowspan=2>Gender
#       <th>Male
#       <td>73%
#       <td>27%
#    </tr>
#    <tr align='center'>
#       <th>Female
#       <td>16%
#       <td>84%
#    </tr>
#    </tbody>
#    <tfoot>
#    <tr>
#       <td colspan=4 align='center'>Note: eye pokes did not result in permanent injury
#    </tr>
#    </tfoot>
# </table>
