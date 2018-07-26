###################################################################
# tag_handler.rb
#
# Module for handling standard html physical tags (<b>, <i>, etc).
# Only used for Table::Content objects, which are in turn used by
# Table::Row::Data, Table::Row::Header and Table::Caption.
###################################################################
module TagHandler
  def bold(bool = nil)
    @bold ||= nil
    self.bold = bool if bool
    @bold
  end

  def bold=(bool)
    handle_physical_tag('b', bool)
    @bold = bool
  end

  def big(bool = nil)
    @big ||= nil
    self.big = bool if bool
    @big
  end

  def big=(bool)
    handle_physical_tag('big', bool)
    @big = bool
  end

  def blink(bool = nil)
    @blink ||= nil
    self.blink = bool if bool
    @blink
  end

  def blink=(bool)
    warn BlinkWarning, "The 'blink' tag is very annoying. Please reconsider."
    handle_physical_tag('blink', bool)
    @blink = bool
  end

  def italic(bool = nil)
    @italic ||= nil
    self.italic = bool if bool
    @italic
  end

  def italic=(bool)
    handle_physical_tag('i', bool)
    @italic = bool
  end

  def strike(bool = nil)
    @strike ||= nil
    self.strike = bool if bool
    @strike
  end

  def strike=(bool)
    handle_physical_tag('strike', bool)
    @strike = bool
  end

  def sub(bool = nil)
    @sub ||= nil
    self.sub = bool if bool
    @sub
  end

  def sub=(bool)
    handle_physical_tag('sub', bool)
    @sub = bool
  end

  def sup(bool = nil)
    @sup ||= nil
    self.sup = bool if bool
    @sup
  end

  def sup=(bool)
    handle_physical_tag('sup', bool)
    @sup = bool
  end

  def tt(bool = nil)
    @tt ||= nil
    self.tt = bool if bool
    @tt
  end

  def tt=(bool)
    handle_physical_tag('tt', bool)
    @tt = bool
  end

  def underline(bool = nil)
    @underline ||= nil
    self.underline = bool if bool
    @underline
  end

  def underline=(bool)
    handle_physical_tag('u', bool)
    @bool = bool
  end

  private

  def handle_physical_tag(tag, bool)
    begin_tag = "<#{tag}>"
    end_tag = "</#{tag}>"

    if bool
      replace(begin_tag << self << end_tag)
    else
      replace(gsub(/#{begin_tag}|#{end_tag}/, ''))
    end
  end
end
