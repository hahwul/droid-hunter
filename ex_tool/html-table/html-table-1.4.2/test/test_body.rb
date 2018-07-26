############################################
# test_body.rb
#
# Test suite for the Table::Body class
############################################
require 'test-unit'
require 'html/table'
include HTML

class TC_HTML_Table_Body < Test::Unit::TestCase
  def setup
    @table = Table.new
    @tbody = Table::Body.new
  end

  def test_constructor
    assert_nothing_raised { Table::Body.new }
    assert_nothing_raised { Table::Body.new('foo') }
    assert_nothing_raised { Table::Body.new(1) }
    assert_nothing_raised { Table::Body.new(%w[foo bar baz]) }
    assert_nothing_raised { Table::Body.new([1, 2, 3]) }
    assert_nothing_raised { Table::Body.new([[1, 2, 3], %w[foo bar]]) }
  end

  def test_basic
    html = '<tbody></tbody>'
    assert_equal(html, @tbody.html.gsub(/\s{2,}|\n/, ''))
  end

  def test_with_attributes
    html = "<tbody align='left' char='x'></tbody>"
    @tbody.align = 'left'
    @tbody.char = 'x'
    assert_equal(html, @tbody.html.gsub(/\s{2,}|\n/, ''))
  end

  def test_push_single_row
    html = '<tbody><tr><td>test</td></tr></tbody>'
    @tbody.push Table::Row.new { |r| r.content = 'test' }
    assert_equal(html, @tbody.html.gsub(/\s{2,}|\n/, ''))
  end

  def test_push_multiple_rows
    html = '<tbody><tr><td>test</td></tr><tr><td>foo</td></tr></tbody>'
    r1 = Table::Row.new { |r| r.content = 'test' }
    r2 = Table::Row.new { |r| r.content = 'foo' }
    @tbody.push r1, r2
    assert_equal(html, @tbody.html.gsub(/\s{2,}|\n/, ''))
  end

  def test_add_content_directly
    html = '<tbody><tr><td>hello</td><td>world</td></tr></tbody>'
    @tbody.content = 'hello', 'world'
    assert_equal(html, @tbody.html.gsub(/\s{2,}|\n+/, ''))
  end

  def test_add_content_in_constructor
    html = '<tbody><tr><td>hello</td><td>world</td></tr></tbody>'
    tb = Table::Body.new(%w[hello world])
    assert_equal(html, tb.html.gsub(/\s{2,}|\n+/, ''))
  end

  def test_configure_column
    html = "<tbody><tr><td>hello</td><td abbr='test' width=3 nowrap>world"
    html += '</td></tr></tbody>'
    @tbody.content = 'hello', 'world'
    @tbody.configure(0, 1) do |data|
      data.abbr = 'test'
      data.width  = 3
      data.nowrap = true
    end
    assert_equal(html, @tbody.html.gsub(/\s{2,}|\n+/, ''))
  end

  def test_end_tags
    assert_respond_to(Table::Body, :end_tags?)
    assert_respond_to(Table::Body, :end_tags=)
    assert_raises(ArgumentTypeError) { Table::Body.end_tags = 'foo' }
    assert_raises(ArgumentTypeError) { Table::Body.end_tags = 1 }
    assert_nothing_raised { Table::Body.end_tags = true }
  end

  def teardown
    @table = nil
    @tbody = nil
  end
end
