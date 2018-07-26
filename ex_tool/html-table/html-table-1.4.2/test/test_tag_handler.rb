############################################################################
# test_tag_handler.rb
#
# Test suite for the TagHandler module. For these tests, we'll use an
# instance of the Table class where the module has been mixed in.
############################################################################
require 'test-unit'
require 'html/table'
include HTML

class TC_TagHandler < Test::Unit::TestCase
  def self.startup
    BlinkWarning.disable
  end

  def setup
    @tcontent = Table::Content.new('test')
  end

  def test_bold
    assert_respond_to(@tcontent, :bold)
    assert_respond_to(@tcontent, :bold=)
    assert_nothing_raised { @tcontent.bold }
    assert_nothing_raised { @tcontent.bold = true }
  end

  def test_big
    assert_respond_to(@tcontent, :big)
    assert_respond_to(@tcontent, :big=)
    assert_nothing_raised { @tcontent.big }
    assert_nothing_raised { @tcontent.big = true }
  end

  def test_blink
    assert_respond_to(@tcontent, :blink)
    assert_respond_to(@tcontent, :blink=)
    assert_nothing_raised { @tcontent.blink }
    assert_nothing_raised { @tcontent.blink = true }
  end

  def test_italic
    assert_respond_to(@tcontent, :italic)
    assert_respond_to(@tcontent, :italic=)
    assert_nothing_raised { @tcontent.italic }
    assert_nothing_raised { @tcontent.italic = true }
  end

  def test_strike
    assert_respond_to(@tcontent, :strike)
    assert_respond_to(@tcontent, :strike=)
    assert_nothing_raised { @tcontent.strike }
    assert_nothing_raised { @tcontent.strike = true }
  end

  def test_sub
    assert_respond_to(@tcontent, :sub)
    assert_respond_to(@tcontent, :sub)
    assert_nothing_raised { @tcontent.sub }
    assert_nothing_raised { @tcontent.sub = true }
  end

  def test_sup
    assert_respond_to(@tcontent, :sup)
    assert_respond_to(@tcontent, :sup)
    assert_nothing_raised { @tcontent.sup }
    assert_nothing_raised { @tcontent.sup = true }
  end

  def test_tt
    assert_respond_to(@tcontent, :tt)
    assert_respond_to(@tcontent, :tt)
    assert_nothing_raised { @tcontent.tt }
    assert_nothing_raised { @tcontent.tt = true }
  end

  def test_underline
    assert_respond_to(@tcontent, :underline)
    assert_respond_to(@tcontent, :underline)
    assert_nothing_raised { @tcontent.underline }
    assert_nothing_raised { @tcontent.underline = true }
  end

  def teardown
    @tcontent = nil
  end

  def self.shutdown
    BlinkWarning.enable
  end
end
