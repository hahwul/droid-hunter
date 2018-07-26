############################################
# test_row.rb
#
# Test suite for the Table::Row class
############################################
require 'test-unit'
require 'html/table'
include HTML

class TC_HTML_Table_Row < Test::Unit::TestCase
  def setup
    @trow = Table::Row.new
  end

  def test_constructor
    assert_nothing_raised { Table::Row.new }
    assert_nothing_raised { Table::Row.new('foo') }
    assert_nothing_raised { Table::Row.new(1) }
    assert_nothing_raised { Table::Row.new([1, 2, 3]) }
    assert_nothing_raised { Table::Row.new([[1, 2, 3], %w[foo bar]]) }
  end

  def test_basic
    html = '<tr></tr>'
    assert_equal(html, @trow.html.gsub(/\s+/, ''))
  end

  def test_header
    assert_respond_to(@trow, :header?)
    assert_respond_to(@trow, :header=)
    assert_nothing_raised { @trow.header? }
    assert_nothing_raised { @trow.header = true }
  end

  def test_with_attributes
    html = "<tr align='center'></tr>"
    @trow.align = 'center'
    assert_equal(html, @trow.html.gsub(/\s{2,}|\n+/, ''))
  end

  def test_index_assignment_constraints
    assert_raises(ArgumentTypeError) { @trow[0] = 'foo' }
    assert_raises(ArgumentTypeError) { @trow[0] = 1 }
    assert_raises(ArgumentTypeError) { @trow[0] = Table::Caption.new }
    assert_nothing_raised { @trow[0] = Table::Row::Data.new }
    assert_nothing_raised { @trow[0] = Table::Row::Header.new }
  end

  def test_push_constraints
    assert_raises(ArgumentTypeError) { @trow.push(Table::Caption.new) }
    assert_raises(ArgumentTypeError) { @trow.push(nil) }
    assert_nothing_raised { @trow.push('test') }
    assert_nothing_raised { @trow.push(7) }
    assert_nothing_raised { @trow.push(Table::Row::Data.new) }
    assert_nothing_raised { @trow.push(Table::Row::Header.new) }
  end

  # Test the '<<' method
  def test_doubl_arrow_constraints
    assert_raises(ArgumentTypeError) { @trow << Table::Caption.new }
    assert_nothing_raised { @trow << 'test' }
    assert_nothing_raised { @trow << 'test' << 'foo' }
    assert_nothing_raised { @trow << Table::Row::Data.new }
    assert_nothing_raised { @trow << Table::Row::Header.new }
  end

  def test_header_in_constructor
    assert_nothing_raised { @trow = Table::Row.new('test', true) }
    html = '<tr><th>test</th></tr>'
    assert_equal(html, @trow.html.gsub(/\s+/, ''))
  end

  def test_push_single_data_element
    html = '<tr><td>hello</td></tr>'
    @trow.push Table::Row::Data.new { |d| d.content = 'hello' }
    assert_equal(html, @trow.html.gsub(/\s{2,}|\n+/, ''))
  end

  def test_push_multiple_data_element
    html = '<tr><td>hello</td><td>world</td></tr>'
    d1 = Table::Row::Data.new { |d| d.content = 'hello' }
    d2 = Table::Row::Data.new { |d| d.content = 'world' }
    @trow.push d1, d2
    assert_equal(html, @trow.html.gsub(/\s{2,}|\n+/, ''))
  end

  def test_add_content_directly
    html = '<tr><td>hello</td><td>world</td></tr>'
    @trow.content = 'hello', 'world'
    assert_equal(html, @trow.html.gsub(/\s{2,}|\n+/, ''))
  end

  def test_add_content_in_constructor
    html = '<tr><td>hello</td><td>world</td></tr>'
    @trow = Table::Row.new(%w[hello world])
    assert_equal(html, @trow.html.gsub(/\s{2,}|\n+/, ''))
  end

  def test_configure_column
    html = "<tr><td>hello</td><td abbr='test' width=3 nowrap>world</td></tr>"
    @trow.content = 'hello', 'world'
    @trow.configure(1) do |d|
      d.abbr = 'test'
      d.width = 3
      d.nowrap = true
    end
    assert_equal(html, @trow.html.gsub(/\s{2,}|\n+/, ''))
  end

  def test_unshift_constraints
    assert_raises(ArgumentTypeError) { @trow.unshift(Table::Caption.new) }
    assert_raises(ArgumentTypeError) { @trow.unshift(nil) }
    assert_nothing_raised { @trow.unshift('test') }
    assert_nothing_raised { @trow.unshift(7) }
    assert_nothing_raised { @trow.unshift(Table::Row::Data.new) }
    assert_nothing_raised { @trow.unshift(Table::Row::Header.new) }
  end

  def test_configure_error
    assert_raises(ArgumentError) { @trow.configure(0, 0) {} }
  end

  def test_indent_level
    assert_respond_to(Table::Row, :indent_level)
    assert_respond_to(Table::Row, :indent_level=)
    assert_raises(ArgumentTypeError) { Table::Row.indent_level = 'foo' }
    assert_nothing_raised { Table::Row.indent_level = 3 }
  end

  def test_end_tags
    assert_respond_to(Table::Row, :end_tags?)
    assert_respond_to(Table::Row, :end_tags=)
    assert_raises(ArgumentTypeError) { Table::Row.end_tags = 'foo' }
    assert_raises(ArgumentTypeError) { Table::Row.end_tags = 1 }
    assert_nothing_raised { Table::Row.end_tags = true }
  end

  def teardown
    @trow = nil
  end
end
