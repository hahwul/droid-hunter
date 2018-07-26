##############################################
# test_data.rb
#
# Test suite for the Table::Row::Data class
##############################################
require 'test-unit'
require 'html/table'
include HTML

class TC_HTML_Table_Row_Data < Test::Unit::TestCase
  def setup
    @tdata = Table::Row::Data.new
  end

  def test_constructor
    assert_nothing_raised { Table::Row::Data.new }
    assert_nothing_raised { Table::Row::Data.new('foo') }
    assert_nothing_raised { Table::Row::Data.new(1) }
    assert_nothing_raised { Table::Row::Data.new(%w[foo bar baz]) }
    assert_nothing_raised { Table::Row::Data.new([1, 2, 3]) }
    assert_nothing_raised { Table::Row::Data.new([[1, 2, 3], %w[foo bar]]) }
  end

  def test_basic
    html = '<td></td>'
    assert_equal(html, @tdata.html.gsub(/\s+/, ''))
  end

  def test_with_attributes
    html = "<td align='left' width=3 nowrap></td>"
    @tdata.align = 'left'
    @tdata.width = 3
    @tdata.nowrap = true
    assert_equal(html, @tdata.html.gsub(/\s{2,}|\n+/, ''))
  end

  def test_configure_not_allowed
    assert_raises(NoMethodError) { @tdata.configure }
  end

  def test_add_content
    html = '<td>hello world</td>'
    @tdata.content = 'hello world'
    assert_equal(html, @tdata.html.gsub(/\s{2,}/, ''))
  end

  def test_add_content_in_constructor
    html = '<td>hello world</td>'
    td = Table::Row::Data.new('hello world')
    assert_equal(html, td.html.gsub(/\s{2,}/, ''))
  end

  def test_add_multiple_content_items
    html = '<td>hello world</td>'
    @tdata.content = 'hello', ' world'
    assert_equal(html, @tdata.html.gsub(/\s{2,}/, ''))
  end

  def test_indent_level
    assert_respond_to(Table::Row::Data, :indent_level)
    assert_respond_to(Table::Row::Data, :indent_level=)
    assert_raises(ArgumentTypeError) { Table::Row::Data.indent_level = 'foo' }
    assert_nothing_raised { Table::Row::Data.indent_level = 6 }
  end

  def test_end_tags
    assert_respond_to(Table::Row::Data, :end_tags?)
    assert_respond_to(Table::Row::Data, :end_tags=)
    assert_raises(ArgumentTypeError) { Table::Row::Data.end_tags = 'foo' }
    assert_raises(ArgumentTypeError) { Table::Row::Data.end_tags = 1 }
    assert_nothing_raised { Table::Row::Data.end_tags = true }
  end

  def teardown
    @tdata = nil
  end
end
