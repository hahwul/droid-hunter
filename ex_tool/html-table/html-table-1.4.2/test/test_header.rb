################################################
# test_header.rb
#
# Test suite for the Table::Row::Header class
################################################
require 'test-unit'
require 'html/table'
include HTML

class TC_HTML_Table_Row_Header < Test::Unit::TestCase
  def setup
    @theader = Table::Row::Header.new
  end

  def test_basic
    html = '<th></th>'
    assert_equal(html, @theader.html.gsub(/\s+/, ''))
  end

  def test_constructor
    assert_nothing_raised { Table::Row::Header.new }
    assert_nothing_raised { Table::Row::Header.new('foo') }
    assert_nothing_raised { Table::Row::Header.new(1) }
    assert_nothing_raised { Table::Row::Header.new(%w[foo bar baz]) }
    assert_nothing_raised { Table::Row::Header.new([1, 2, 3]) }
    assert_nothing_raised { Table::Row::Header.new([[1, 2, 3], %w[foo bar]]) }
  end

  def test_with_attributes
    html = "<th align='left' colspan=3 nowrap></th>"
    @theader.align = 'left'
    @theader.colspan = 3
    @theader.nowrap = true
    assert_equal(html, @theader.html.gsub(/\s{2,}|\n+/, ''))
  end

  def test_configure_not_allowed
    assert_raises(NoMethodError) { @theader.configure }
  end

  def test_add_content
    html = '<th>hello world</th>'
    @theader.content = 'hello world'
    assert_equal(html, @theader.html.gsub(/\s{2,}/, ''))
  end

  def test_add_multiple_content_items
    html = '<th>hello world</th>'
    @theader.content = 'hello', ' world'
    assert_equal(html, @theader.html.gsub(/\s{2,}/, ''))
  end

  def test_add_content_in_constructor
    html = '<th>hello world</th>'
    @theader = Table::Row::Header.new('hello world')
    assert_equal(html, @theader.html.gsub(/\s{2,}/, ''))
  end

  def test_indent_level
    assert_respond_to(Table::Row::Header, :indent_level)
    assert_respond_to(Table::Row::Header, :indent_level=)
    assert_raises(ArgumentTypeError) { Table::Row::Header.indent_level = 'foo' }
    assert_nothing_raised { Table::Row::Header.indent_level = 6 }
  end

  def test_end_tags
    assert_respond_to(Table::Row::Header, :end_tags?)
    assert_respond_to(Table::Row::Header, :end_tags=)
    assert_raises(ArgumentTypeError) { Table::Row::Header.end_tags = 'foo' }
    assert_raises(ArgumentTypeError) { Table::Row::Header.end_tags = 1 }
    assert_nothing_raised { Table::Row::Header.end_tags = true }
  end

  def teardown
    @theader = nil
  end
end
