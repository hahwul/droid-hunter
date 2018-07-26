############################################
# test_colgroup.rb
#
# Test suite for the Table::ColGroup class
############################################
require 'test-unit'
require 'html/table'
include HTML

class TC_HTML_Table_ColGroup < Test::Unit::TestCase
  def setup
    @cgroup = Table::ColGroup.new
    @col = Table::ColGroup::Col.new
  end

  def test_constructor
    assert_nothing_raised { Table::ColGroup.new }
    assert_nothing_raised { Table::ColGroup.new(@col) }
    assert_raises(TypeError) { Table::ColGroup.new('foo') }
  end

  def test_basic
    html = '<colgroup></colgroup>'
    assert_equal(html, @cgroup.html.gsub(/\s+/, ''))
  end

  def test_with_attributes
    html = "<colgroup align='center' width='20%'></colgroup>"
    @cgroup.align = 'center'
    @cgroup.width = '20%'
    assert_equal(html, @cgroup.html.gsub(/\s{2,}|\n+/, ''))
  end

  def test_push_single_col_element
    html = '<colgroup><col></colgroup>'
    @cgroup.push(@col)
    assert_equal(html, @cgroup.html.gsub(/\s{2,}|\n+/, ''))
  end

  def test_index_assignment_constraints
    assert_raises(ArgumentTypeError) { @cgroup[0] = 'foo' }
    assert_raises(ArgumentTypeError) { @cgroup[0] = 1 }
    assert_raises(ArgumentTypeError) { @cgroup[1] = Table::Row.new }
    assert_nothing_raised { @cgroup[0] = Table::ColGroup::Col.new }
  end

  def test_push_constraints
    assert_raises(TypeError) { @cgroup.push(7) }
    assert_raises(TypeError) { @cgroup.push('hello') }
    assert_raises(TypeError) { @cgroup.push(Table::Row.new) }
    assert_nothing_raised { @cgroup.push(Table::ColGroup::Col.new) }
  end

  # Test '<<'
  def test_double_arrow_constraints
    assert_raises(TypeError) { @cgroup << 7 }
    assert_raises(TypeError) { @cgroup << 'hello' }
    assert_raises(TypeError) { @cgroup << Table::Row.new }
    assert_nothing_raised { @cgroup << Table::ColGroup::Col.new }
  end

  def test_configure_error
    assert_raises(ArgumentError) { @cgroup.configure(0, 0) {} }
  end

  def test_content_error
    assert_raises(NoMethodError) { @cgroup.content }
    assert_raises(NoMethodError) { @cgroup.content = 'blah' }
  end

  def test_indent_level
    assert_respond_to(Table::ColGroup, :indent_level)
    assert_respond_to(Table::ColGroup, :indent_level=)
    assert_raises(ArgumentTypeError) { Table::ColGroup.indent_level = 'foo' }
    assert_nothing_raised { Table::ColGroup.indent_level = 6 }
  end

  def test_end_tags
    assert_respond_to(Table::ColGroup, :end_tags?)
    assert_respond_to(Table::ColGroup, :end_tags=)
    assert_raises(ArgumentTypeError) { Table::ColGroup.end_tags = 'foo' }
    assert_raises(ArgumentTypeError) { Table::ColGroup.end_tags = 1 }
    assert_nothing_raised { Table::ColGroup.end_tags = true }
  end

  def teardown
    @cgroup = nil
  end
end
