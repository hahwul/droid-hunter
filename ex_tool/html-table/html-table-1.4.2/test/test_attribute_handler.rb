############################################################################
# test_attribute_handler.rb
#
# Test suite for the AttributeHandler module. For these tests, we'll use an
# instance of the Table class where the module has been mixed in.
############################################################################
require 'test-unit'
require 'html/table'
include HTML

class TC_AttributeHandler < Test::Unit::TestCase
  def self.startup
    NonStandardExtensionWarning.disable
  end

  def setup
    @table = Table.new(['foo', 1, 'bar'])
  end

  def test_abbr_basic
    assert_respond_to(@table, :abbr)
    assert_respond_to(@table, :abbr=)
  end

  def test_abbr
    assert_nothing_raised { @table.abbr }
    assert_nil(@table.abbr)
    assert_nothing_raised { @table.abbr = 'foo' }
    assert_equal('foo', @table.abbr)
  end

  def test_align_basic
    assert_respond_to(@table, :align)
    assert_respond_to(@table, :align=)
  end

  def test_align
    assert_nothing_raised { @table.align }
    assert_nil(@table.align)
    assert_nothing_raised { @table.align = 'center' }
    assert_equal('center', @table.align)
  end

  def test_align_expected_errors
    assert_raises(ArgumentError) { @table.align = 'foo' }
  end

  def test_axis
    assert_respond_to(@table, :axis)
    assert_respond_to(@table, :axis=)
    assert_nothing_raised { @table.axis }
    assert_nothing_raised { @table.axis = 'foo' }
  end

  def test_background_basic
    assert_respond_to(@table, :background)
    assert_respond_to(@table, :background=)
  end

  def test_background
    assert_nothing_raised { @table.background }
    assert_nil(@table.background)
    assert_nothing_raised { @table.background = 'foo' }
    assert_equal('foo', @table.background)
  end

  def test_background_expected_errors
    assert_raises(TypeError) { @table.background = 1 }
  end

  def test_bgcolor_basic
    assert_respond_to(@table, :bgcolor)
    assert_respond_to(@table, :bgcolor=)
  end

  def test_bgcolor
    assert_nothing_raised { @table.bgcolor }
    assert_nil(@table.bgcolor)
    assert_nothing_raised { @table.bgcolor = 'foo' }
    assert_equal('foo', @table.bgcolor)
  end

  def test_border_basic
    assert_respond_to(@table, :border)
    assert_respond_to(@table, :border=)
  end

  def test_border
    assert_nothing_raised { @table.border }
    assert_nothing_raised { @table.border = 2 }
    assert_nothing_raised { @table.border = true }
    assert_nothing_raised { @table.border = false }
  end

  def test_bordercolor_basic
    assert_respond_to(@table, :bordercolor)
    assert_respond_to(@table, :bordercolor=)
  end

  def test_bordercolor
    assert_nothing_raised { @table.bordercolor }
    assert_nil(@table.bordercolor)
    assert_nothing_raised { @table.bordercolor = 'foo' }
    assert_equal('foo', @table.bordercolor)
  end

  def test_bordercolordark_basic
    assert_respond_to(@table, :bordercolordark)
    assert_respond_to(@table, :bordercolordark=)
  end

  def test_bordercolordark
    assert_nothing_raised { @table.bordercolordark }
    assert_nil(@table.bordercolordark)
    assert_nothing_raised { @table.bordercolordark = 'foo' }
    assert_equal('foo', @table.bordercolordark)
  end

  def test_bordercolorlight
    assert_respond_to(@table, :bordercolorlight)
    assert_respond_to(@table, :bordercolorlight=)
    assert_nothing_raised { @table.bordercolorlight }
    assert_nothing_raised { @table.bordercolorlight = 'foo' }
  end

  def test_cellpadding
    assert_respond_to(@table, :cellpadding)
    assert_respond_to(@table, :cellpadding=)
    assert_nothing_raised { @table.cellpadding }
    assert_nothing_raised { @table.cellpadding = 1 }
  end

  def test_cellpadding_expected_errors
    assert_raises(ArgumentError) { @table.cellpadding = -1 }
  end

  def test_cellspacing
    assert_respond_to(@table, :cellspacing)
    assert_respond_to(@table, :cellspacing=)
    assert_nothing_raised { @table.cellspacing }
    assert_nothing_raised { @table.cellspacing = 1 }
  end

  def test_cellspacing_expected_errors
    assert_raises(ArgumentError) { @table.cellspacing = -1 }
  end

  def test_char
    assert_respond_to(@table, :char)
    assert_respond_to(@table, :char=)
    assert_nothing_raised { @table.char }
    assert_nothing_raised { @table.char = 'x' }
  end

  def test_char_expected_errors
    assert_raises(ArgumentError) { @table.char = 'xx' }
  end

  def test_charoff
    assert_respond_to(@table, :charoff)
    assert_respond_to(@table, :charoff=)
    assert_nothing_raised { @table.charoff }
    assert_nothing_raised { @table.charoff = 1 }
  end

  def test_charoff_expected_errors
    assert_raises(ArgumentError) { @table.charoff = -1 }
  end

  def test_class
    assert_respond_to(@table, :class_)
    assert_respond_to(@table, :class_=)
    assert_nothing_raised { @table.class_ }
    assert_nothing_raised { @table.class_ = 'myclass' }
  end

  def test_col
    assert_respond_to(@table, :col)
    assert_respond_to(@table, :col=)
    assert_nothing_raised { @table.col }
    assert_nothing_raised { @table.col = 1 }
  end

  def test_col_expected_errors
    assert_raises(ArgumentError) { @table.col = -1 }
  end

  def test_colspan
    assert_respond_to(@table, :colspan)
    assert_respond_to(@table, :colspan=)
    assert_nothing_raised { @table.colspan }
    assert_nothing_raised { @table.colspan = 1 }
  end

  def test_colspan_expected_errors
    assert_raises(ArgumentError) { @table.colspan = -1 }
  end

  def test_configure
    assert_respond_to(@table, :configure)
    assert_nothing_raised { @table.configure(0) {} }
    assert_nothing_raised { @table.configure(0, 0) {} }
  end

  def test_configure_expected_errors
    assert_raises(ArgumentError) { @table.configure(0, 0, 0) {} }
  end

  ########################################################################
  # This test could probably be broken out into separate tests for each
  # type that we want to add as content.
  ########################################################################
  def test_content
    assert_respond_to(@table, :content)
    assert_respond_to(@table, :content=)
    assert_nothing_raised { @table.content = 'foo' }
    assert_nothing_raised { @table.content = 123 }
    assert_nothing_raised { @table.content = ['one', 2, 'three'] }
    assert_nothing_raised { @table.content = [%w[foo bar], [1, 2, 3]] }
    assert_nothing_raised { @table.content = Table::Row.new }
    assert_nothing_raised { @table.content = Table::Row::Data.new }
    assert_nothing_raised { @table.content = Table::Row::Header.new }
    assert_nothing_raised { @table.content = Table::Head.create }
    assert_nothing_raised { @table.content = Table::Foot.create }
    assert_nothing_raised { @table.content = Table::Body.new }
  end

  def test_frame
    assert_respond_to(@table, :frame)
    assert_respond_to(@table, :frame=)
    assert_nothing_raised { @table.frame }
    assert_nothing_raised { @table.frame = 'below' }
  end

  def test_frame_expected_errors
    assert_raises(ArgumentError) { @table.frame = 'foo' }
  end

  def test_height
    assert_respond_to(@table, :height)
    assert_respond_to(@table, :height=)
    assert_nothing_raised { @table.height }
    assert_nothing_raised { @table.height = 1 }
  end

  def test_height_expected_errors
    assert_raises(ArgumentError) { @table.height = -1 }
  end

  def test_hspace
    assert_respond_to(@table, :hspace)
    assert_respond_to(@table, :hspace=)
    assert_nothing_raised { @table.hspace }
    assert_nothing_raised { @table.hspace = 1 }
  end

  def test_hspace_expected_errors
    assert_raises(ArgumentError) { @table.hspace = -1 }
  end

  def test_nowrap
    assert_respond_to(@table, :nowrap)
    assert_respond_to(@table, :nowrap=)
    assert_nothing_raised { @table.nowrap }
    assert_nothing_raised { @table.nowrap = false }
  end

  def test_nowrap_expected_errors
    assert_raises(TypeError) { @table.nowrap = 'foo' }
  end

  def test_rowspan
    assert_respond_to(@table, :rowspan)
    assert_respond_to(@table, :rowspan=)
    assert_nothing_raised { @table.rowspan }
    assert_nothing_raised { @table.rowspan = 1 }
  end

  def test_rowspan_expected_errors
    assert_raises(ArgumentError) { @table.rowspan = -1 }
  end

  def test_rules
    assert_respond_to(@table, :rules)
    assert_respond_to(@table, :rules=)
    assert_nothing_raised { @table.rules }
    assert_nothing_raised { @table.rules = 'all' }
  end

  def test_rules_expected_errors
    assert_raises(ArgumentError) { @table.rules = 'foo' }
  end

  def test_span
    assert_respond_to(@table, :span)
    assert_respond_to(@table, :span=)
    assert_nothing_raised { @table.span }
    assert_nothing_raised { @table.span = 1 }
  end

  def test_span_expected_errors
    assert_raises(ArgumentError) { @table.span = -1 }
  end

  def test_style
    assert_respond_to(@table, :style)
    assert_respond_to(@table, :style=)
    assert_nothing_raised { @table.style }
    assert_nothing_raised { @table.style = 'color: blue' }
  end

  def test_summary
    assert_respond_to(@table, :summary)
    assert_respond_to(@table, :summary=)
    assert_nothing_raised { @table.summary }
    assert_nothing_raised { @table.summary = 'foo' }
    assert_nothing_raised { @table.summary = 1 }
  end

  def test_valign
    assert_respond_to(@table, :valign)
    assert_respond_to(@table, :valign=)
    assert_nothing_raised { @table.valign }
    assert_nothing_raised { @table.valign = 'center' }
  end

  def test_valign_expected_errors
    assert_raises(ArgumentError) { @table.valign = 'foo' }
  end

  def test_vspace
    assert_respond_to(@table, :vspace)
    assert_respond_to(@table, :vspace=)
    assert_nothing_raised { @table.vspace }
    assert_nothing_raised { @table.vspace = 1 }
  end

  def test_vspace_expected_errors
    assert_raises(ArgumentError) { @table.vspace = -1 }
  end

  def test_width
    assert_respond_to(@table, :width)
    assert_respond_to(@table, :width=)
    assert_nothing_raised { @table.width }
    assert_nothing_raised { @table.width = 10 }
    assert_nothing_raised { @table.width = '5%' }
  end

  def test_width_expected_errors
    assert_raises(ArgumentError) { @table.width = -1 }
  end

  def teardown
    @table = nil
  end

  def self.shutdown
    NonStandardExtensionWarning.enable
  end
end
