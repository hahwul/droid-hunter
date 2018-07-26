#######################################################################
# test_table.rb
#
# Test suite for the HTML::Table class. This test case should be run
# via the 'rake test' task.
#######################################################################
require 'test-unit'
require 'html/table'
require 'strongtyping'
include StrongTyping
include HTML

class TC_HTML_Table < Test::Unit::TestCase
  def setup
    @table = Table.new
  end

  def test_version
    assert_equal('1.4.2', Table::VERSION)
  end

  def test_constructor
    assert_nothing_raised { Table.new }
    assert_nothing_raised { Table.new('foo') }
    assert_nothing_raised { Table.new(1) }
    assert_nothing_raised { Table.new(%w[foo bar baz]) }
    assert_nothing_raised { Table.new([1, 2, 3]) }
    assert_nothing_raised { Table.new([[1, 2, 3], %w[foo bar]]) }
  end

  def test_constructor_with_attributes
    assert_nothing_raised { Table.new(%w[foo bar baz], border: 1) }
  end

  def test_html_case
    assert_respond_to(Table, :html_case)
    assert_respond_to(Table, :html_case=)
    assert_nothing_raised { Table.html_case = 'upper' }
    assert_nothing_raised { Table.html_case = 'lower' }
    assert_raises(ArgumentError) { Table.html_case = 'foo' }
    assert_raises(ArgumentTypeError) { Table.html_case = 7 }
  end

  def test_indent_level
    assert_respond_to(Table, :indent_level)
    assert_respond_to(Table, :indent_level=)
    assert_nothing_raised { Table.indent_level = 0 }
    assert_raises(ArgumentTypeError) { Table.indent_level = 'foo' }
  end

  def test_index
    assert_raises(ArgumentTypeError) { @table[0] = 'foo' }
  end

  def test_caption_index_constraints
    assert_nothing_raised { @table[0] = Table::Caption.new }
    assert_raises(ArgumentError) { @table[1] = Table::Caption.new }
  end

  def test_head_index_constraints
    assert_nothing_raised { @table[0] = Table::Head.create }
    assert_raises(ArgumentError) { @table[1] = Table::Head.create }
    assert_raises(ArgumentError) { @table[2] = Table::Head.create }
  end

  def test_foot_index_constraints
    assert_nothing_raised do
      @table[0] = Table::Caption.new
      @table[-1] = Table::Foot.create
    end
    assert_raises(ArgumentError) { @table[0] = Table::Foot.create }
  end

  def test_unshift_constraints
    assert_nothing_raised { @table.unshift Table::Row.new }
    assert_raises(ArgumentTypeError) { @table.unshift Table::Row::Data.new }
    assert_raises(ArgumentTypeError) { @table.unshift 'foo' }
  end

  def test_push_constraints
    assert_nothing_raised { @table.push Table::Row.new }
    assert_raises(ArgumentTypeError) { @table.push('foo') }
    assert_raises(ArgumentTypeError) { @table.push(7) }
    assert_raises(ArgumentTypeError) { @table.push(nil) }
  end

  def test_double_arrow_constraints
    assert_nothing_raised { @table << Table::Row.new }
    assert_nothing_raised { @table << Table::Row.new << Table::Row.new }
    assert_raises(ArgumentTypeError) { @table << 'foo' }
    assert_raises(ArgumentTypeError) { @table << 7 }
    assert_raises(ArgumentTypeError) { @table << nil }
  end

  def test_basic
    html = "<table>\n</table>"
    assert_equal(html, @table.html)
  end

  def test_with_attributes
    html = "<table border=1 align='left' nowrap>\n</table>"
    @table.border = 1
    @table.align = 'left'
    @table.nowrap = true
    assert_equal(html, @table.html)
  end

  def test_add_row_push
    html = '<table><tr></tr></table>'
    @table.push(Table::Row.new)
    assert_equal(html, @table.html.gsub(/\s+/, ''))
  end

  def test_add_row_by_index
    html = '<table><tr></tr></table>'
    @table[0] = Table::Row.new
    assert_equal(html, @table.html.gsub(/\s+/, ''))
  end

  def test_add_multiple_rows
    html = '<table><tr></tr><tr></tr></table>'
    @table.push Table::Row.new, Table::Row.new
    assert_equal(html, @table.html.gsub(/\s+/, ''))
  end

  def test_add_single_data_element
    html = '<table><tr><td>hello</td></tr></table>'
    @table.content = 'hello'
    assert_equal(html, @table.html.gsub(/\s+/, ''))
  end

  def test_add_multiple_data_elements
    html = '<table><tr><td>hello</td></tr><tr><td>world</td></tr></table>'
    @table.content = 'hello', 'world'
    assert_equal(html, @table.html.gsub(/\s+/, ''))
  end

  def test_configure_row
    html = "<table><tr align='center'><td bgcolor='red'>hello</td></tr>"
    html << '</table>'
    @table.push Table::Row::Data.new { |d| d.content = 'hello' }
    @table.configure(0) { |t| t.align = 'center' }
    @table.configure(0, 0) { |d| d.bgcolor = 'red' }
    assert_equal(html, @table.html.gsub(/\s{2,}|\n+/, ''))
  end

  def test_global_end_tags
    assert_respond_to(Table, :global_end_tags?)
    assert_respond_to(Table, :global_end_tags=)
    assert_nothing_raised { Table.global_end_tags = false }
    assert_nothing_raised { Table.global_end_tags = true }
    assert_raises(ArgumentTypeError) { Table.global_end_tags = 'foo' }
  end

  def teardown
    @table = nil
  end
end
