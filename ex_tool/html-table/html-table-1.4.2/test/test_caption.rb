################################################
# test_caption.rb
#
# Test suite for the Table::Caption class
################################################
require 'test-unit'
require 'html/table'
include HTML

class TC_HTML_Table_Caption < Test::Unit::TestCase
  def setup
    @table = Table.new
    @tcaption = Table::Caption.new
  end

  def test_constructor
    assert_nothing_raised { Table::Caption.new }
    assert_nothing_raised { Table::Caption.new('foo') }
    assert_nothing_raised { Table::Caption.new(1) }
    assert_nothing_raised { Table::Caption.new(%w[foo bar baz]) }
    assert_nothing_raised { Table::Caption.new([1, 2, 3]) }
    assert_nothing_raised { Table::Caption.new([[1, 2, 3], %w[foo bar]]) }
  end

  def test_basic
    html = '<caption></caption>'
    assert_equal(html, @tcaption.html.gsub(/\s+/, ''))
  end

  def test_with_attributes
    html = "<caption align='left' valign='top'></caption>"
    @tcaption.align = 'left'
    @tcaption.valign = 'top'
    assert_equal(html, @tcaption.html.gsub(/\s{2,}|\n+/, ''))
  end

  def test_configure_not_allowed
    assert_raises(NoMethodError) { @tcaption.configure }
  end

  def test_add_content
    html = '<caption>hello world</caption>'
    @tcaption.content = 'hello world'
    assert_equal(html, @tcaption.html.gsub(/\s{2,}/, ''))
  end

  def test_add_multiple_content_items
    html = '<caption>hello world</caption>'
    @tcaption.content = 'hello', ' world'
    assert_equal(html, @tcaption.html.gsub(/\s{2,}/, ''))
  end

  def test_add_content_in_constructor
    html = '<caption>hello world</caption>'
    @tcaption = Table::Caption.new('hello world')
    assert_equal(html, @tcaption.html.gsub(/\s{2,}/, ''))
  end

  def test_indent_level
    assert_respond_to(Table::Caption, :indent_level)
    assert_respond_to(Table::Caption, :indent_level=)
    assert_raises(ArgumentTypeError) { Table::Caption.indent_level = 'foo' }
    assert_nothing_raised { Table::Caption.indent_level = 3 }
  end

  def test_only_row_zero_allowed
    assert_raises(ArgumentError) { @table[1] = @tcaption }
  end

  def test_automatically_set_to_row_zero
    @table.content = 'hello', 'world'
    @table.push(@tcaption)
    assert_equal(true, @table[0].is_a?(Table::Caption))
  end

  def teardown
    @table = nil
    @tcaption = nil
  end
end
