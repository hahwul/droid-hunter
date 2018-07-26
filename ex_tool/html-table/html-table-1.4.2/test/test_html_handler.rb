############################################################################
# test_html_handler.rb
#
# Test suite for the HtmlHandler module. For these tests, we'll use an
# instance of the Table class where the module has been mixed in.
############################################################################
require 'test-unit'
require 'html/table'
include HTML

class TC_HtmlHandler < Test::Unit::TestCase
  def setup
    @table = Table.new(['foo', 1, 'bar'])
  end

  def test_html
    assert_respond_to(@table, :html)
    assert_nothing_raised { @table.html }
    assert_raises(NoMethodError) { @table.html = 'foo' }
    assert_kind_of(String, @table.html)
    assert_equal(true, !@table.html.empty?)
  end

  def test_modify_html
    assert_raises(ArgumentError) { @table.send(:modify_html) }
    assert_nothing_raised { @table.send(:modify_html, 'nowrap') }
    assert_nothing_raised { @table.send(:modify_html, 'align', 'top') }
    assert_nothing_raised do
      @table.send(:modify_html, 'align', 'top')
      @table.send(:modify_html, 'align', 'top')
    end
  end

  def teardown
    @table = nil
  end
end
