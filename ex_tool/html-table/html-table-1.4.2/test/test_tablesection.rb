################################################
# test_tablesection.rb
#
# Test suite for the Table::TableSection class
################################################
require 'test-unit'
require 'html/table'
include HTML

class TC_HTML_Table_TableSection < Test::Unit::TestCase
  def setup
    @table = Table.new
    @tsection = Table::TableSection.new
  end

  def test_indent_level
    assert_respond_to(Table::Caption, :indent_level)
    assert_respond_to(Table::Caption, :indent_level=)
    assert_raises(ArgumentTypeError) { Table::Caption.indent_level = 'foo' }
    assert_nothing_raised { Table::Caption.indent_level = 3 }
  end

  def test_indices
    assert_raises(ArgumentTypeError) { @tsection[0] = 'foo' }
    assert_nothing_raised { @tsection[0] = Table::Row.new }
  end

  def test_push
    assert_raises(ArgumentTypeError) { @tsection.push('foo') }
    assert_nothing_raised { @tsection.push(Table::Row.new) }
  end

  def test_unshift
    assert_raises(ArgumentTypeError) { @tsection.unshift('foo') }
    assert_nothing_raised { @tsection.unshift(Table::Row.new) }
  end

  def teardown
    @table = nil
    @tsection = nil
  end
end
