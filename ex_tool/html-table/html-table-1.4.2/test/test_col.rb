##################################################
# test_col.rb
#
# Test suite for the Table::ColGroup::Col class
##################################################
require 'test-unit'
require 'html/table'
include HTML

class TC_HTML_Table_Col < Test::Unit::TestCase
  def setup
    @col = Table::ColGroup::Col.new
    @cgroup = Table::ColGroup.new
  end

  def test_basic
    html = '<col>'
    assert_equal(html, @col.html.gsub(/\s{2,}|\n+/, ''))
  end

  def test_no_configure
    assert_raises(NoMethodError) { @col.configure }
  end

  def test_no_content_allowed
    assert_raises(NoMethodError) { @col.content }
    assert_raises(NoMethodError) { @col.content = 'foo' }
  end

  def test_indent_level
    assert_respond_to(Table::ColGroup::Col, :indent_level)
    assert_respond_to(Table::ColGroup::Col, :indent_level=)
    assert_raises(ArgumentTypeError) { Table::ColGroup::Col.indent_level = 'foo' }
    assert_nothing_raised { Table::ColGroup::Col.indent_level = 6 }
  end

  def teardown
    @col = nil
  end
end
