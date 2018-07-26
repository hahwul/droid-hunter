###############################################################################
# test_foot.rb
#
# Test suite for the Table::Foot class.  The Table::Foot class is a singleton
# class, so we have to take extra measures to ensure that a fresh instance
# is created between tests.
###############################################################################
require 'test-unit'
require 'html/table'
include HTML

#####################################################################
# Ensure that a fresh instance of Table::Foot is used between tests
# by calling 'refresh' in the 'teardown' method.
#####################################################################
class Table::Foot
  private

  def refresh
    @@foot = nil
  end
end

class TC_HTML_Table_Foot < Test::Unit::TestCase
  def setup
    @table = Table.new
    @tfoot = Table::Foot.create
  end

  def test_new_not_allowed
    assert_raises(NoMethodError) { Table::Foot.new }
  end

  def test_constructor
    assert_nothing_raised { Table::Foot.create }
    assert_nothing_raised { Table::Foot.create('foo') }
    assert_nothing_raised { Table::Foot.create(1) }
    assert_nothing_raised { Table::Foot.create(%w[foo bar baz]) }
    assert_nothing_raised { Table::Foot.create([1, 2, 3]) }
    assert_nothing_raised { Table::Foot.create([[1, 2, 3], %w[foo bar]]) }
  end

  def test_basic
    html = '<tfoot></tfoot>'
    assert_equal(html, @tfoot.html.gsub(/\s{2,}|\n/, ''))
  end

  def test_end_tags
    assert_respond_to(Table::Foot, :end_tags?)
    assert_respond_to(Table::Foot, :end_tags=)
    assert_nothing_raised { Table::Foot.end_tags? }
    assert_nothing_raised { Table::Foot.end_tags = true }
  end

  def test_end_tags_expected_errors
    assert_raises(StrongTyping::ArgumentTypeError) do
      Table::Foot.end_tags = 'foo'
    end
  end

  def test_with_attributes
    html = "<tfoot align='left' char='x'></tfoot>"
    @tfoot.align = 'left'
    @tfoot.char = 'x'
    assert_equal(html, @tfoot.html.gsub(/\s{2,}|\n/, ''))
  end

  def test_push_single_row
    html = '<tfoot><tr><td>test</td></tr></tfoot>'
    @tfoot.push Table::Row.new { |r| r.content = 'test' }
    assert_equal(html, @tfoot.html.gsub(/\s{2,}|\n/, ''))
  end

  def test_push_multiple_rows
    html = '<tfoot><tr><td>test</td></tr><tr><td>foo</td></tr></tfoot>'
    r1 = Table::Row.new { |r| r.content = 'test' }
    r2 = Table::Row.new { |r| r.content = 'foo' }
    @tfoot.push r1, r2
    assert_equal(html, @tfoot.html.gsub(/\s{2,}|\n/, ''))
  end

  def test_add_content_directly
    html = '<tfoot><tr><td>hello</td><td>world</td></tr></tfoot>'
    @tfoot.content = 'hello', 'world'
    assert_equal(html, @tfoot.html.gsub(/\s{2,}|\n+/, ''))
  end

  def test_add_content_in_constructor
    html = '<tfoot><tr><td>hello</td><td>world</td></tr></tfoot>'
    @tfoot.send(:refresh)
    @tfoot = Table::Foot.create(%w[hello world])
    assert_equal(html, @tfoot.html.gsub(/\s{2,}|\n+/, ''))
  end

  def test_configure_column
    html = "<tfoot><tr><td>hello</td><td abbr='test' width=3 nowrap>world"
    html += '</td></tr></tfoot>'
    @tfoot.content = 'hello', 'world'
    @tfoot.configure(0, 1) do |data|
      data.abbr = 'test'
      data.width  = 3
      data.nowrap = true
    end
    assert_equal(html, @tfoot.html.gsub(/\s{2,}|\n+/, ''))
  end

  def teardown
    @table = nil
    @tfoot.send(:refresh)
    @tfoot = nil
  end
end
