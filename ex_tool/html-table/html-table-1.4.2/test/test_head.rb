###############################################################################
# test_head.rb
#
# Test suite for the Table::Head class.  The Table::Head class is a singleton
# class, so we have to take extra measures to ensure that a fresh instance
# is created between tests.
###############################################################################
require 'test-unit'
require 'html/table'
include HTML

#####################################################################
# Ensure that a fresh instance of Table::Head is used between tests
# by calling 'refresh' in the 'teardown' method.
#####################################################################
class Table::Head
  private

  def refresh
    @@head = nil
  end
end

class TC_HTML_Table_Head < Test::Unit::TestCase
  def setup
    @table = Table.new
    @thead = Table::Head.create
  end

  def test_constructor
    assert_nothing_raised { Table::Head.create }
    assert_nothing_raised { Table::Head.create('foo') }
    assert_nothing_raised { Table::Head.create(1) }
    assert_nothing_raised { Table::Head.create(%w[foo bar baz]) }
    assert_nothing_raised { Table::Head.create([1, 2, 3]) }
    assert_nothing_raised { Table::Head.create([[1, 2, 3], %w[foo bar]]) }
  end

  def test_basic
    html = '<thead></thead>'
    assert_equal(html, @thead.html.gsub(/\s{2,}|\n/, ''))
  end

  def test_end_tags
    assert_respond_to(Table::Head, :end_tags?)
    assert_respond_to(Table::Head, :end_tags=)
    assert_nothing_raised { Table::Head.end_tags? }
    assert_nothing_raised { Table::Head.end_tags = true }
    assert_raises(StrongTyping::ArgumentTypeError) do
      Table::Head.end_tags = 'foo'
    end
  end

  def test_with_attributes
    html = "<thead align='left' char='x'></thead>"
    @thead.align = 'left'
    @thead.char = 'x'
    assert_equal(html, @thead.html.gsub(/\s{2,}|\n/, ''))
  end

  def test_push_single_row
    html = '<thead><tr><td>test</td></tr></thead>'
    @thead.push Table::Row.new { |r| r.content = 'test' }
    assert_equal(html, @thead.html.gsub(/\s{2,}|\n/, ''))
  end

  def test_push_multiple_rows
    html = '<thead><tr><td>test</td></tr><tr><td>foo</td></tr></thead>'
    r1 = Table::Row.new('test')
    r2 = Table::Row.new('foo')
    @thead.push(r1, r2)
    assert_equal(html, @thead.html.gsub(/\s{2,}|\n/, ''))
  end

  def test_add_content_directly
    html = '<thead><tr><td>hello</td><td>world</td></tr></thead>'
    @thead.content = 'hello', 'world'
    assert_equal(html, @thead.html.gsub(/\s{2,}|\n+/, ''))
  end

  def test_add_content_in_constructor
    html = '<thead><tr><td>hello</td><td>world</td></tr></thead>'
    @thead.send(:refresh)
    @thead = Table::Head.create(%w[hello world])
    assert_equal(html, @thead.html.gsub(/\s{2,}|\n+/, ''))
  end

  def test_configure_column
    html = "<thead><tr><td>hello</td><td abbr='test' width=3 nowrap>world"
    html += '</td></tr></thead>'
    @thead.content = 'hello', 'world'
    @thead.configure(0, 1) do |d|
      d.abbr = 'test'
      d.width = 3
      d.nowrap = true
    end
    assert_equal(html, @thead.html.gsub(/\s{2,}|\n+/, ''))
  end

  def teardown
    @table = nil
    @thead.send(:refresh)
    @thead = nil
  end
end
