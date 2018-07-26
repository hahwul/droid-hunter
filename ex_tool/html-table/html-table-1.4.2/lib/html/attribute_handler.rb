# This module creates methods for each of the various attributes associated
# with HTML tables.  In some cases validation is done on the setters.
#--
# The seemingly redundant writer methods were left here for backwards
# compatibility and for those who may not prefer the DSI.
#
module AttributeHandler
  def abbr(string = nil)
    @abbr ||= nil
    self.abbr = string if string
    @abbr
  end

  def abbr=(string)
    @abbr = string
    modify_html('abbr', string)
  end

  def align(position = nil)
    @align ||= nil
    self.align = position if position
    @align
  end

  def align=(position)
    valid = %w[top bottom left center right]
    raise ArgumentError unless valid.include?(position.downcase)
    @align = position
    modify_html('align', position)
  end

  def axis(string = nil)
    @axis ||= nil
    self.axis = string if string
    @axis
  end

  def axis=(string)
    @axis = string
    modify_html('axis', string)
  end

  def background(url = nil)
    @background ||= nil
    self.background = url if url
    @background
  end

  def background=(url)
    raise TypeError unless url.is_a?(String)
    msg = "'background' is a non-standard extension"
    warn NonStandardExtensionWarning, msg
    @background = url
    modify_html('background', url)
  end

  def bgcolor(color = nil)
    @bgcolor ||= nil
    self.bgcolor = color if color
    @bgcolor
  end

  def bgcolor=(color)
    @bgcolor = color
    modify_html('bgcolor', color)
  end

  def border(num = nil)
    @border ||= nil
    self.border = num if num
    @border
  end

  # Allow either true/false or an integer
  def border=(num)
    if num.is_a?(TrueClass)
      modify_html('border', true)
    elsif num.is_a?(FalseClass)
    # Do nothing
    else
       @border = num.to_i
       modify_html('border', num.to_i)
    end
  end

  def bordercolor(color = nil)
    @bordercolor ||= nil
    self.bordercolor = color if color
    @bordercolor
  end

  def bordercolor=(color)
    @bordercolor = color
    msg = "'bordercolor' is a non-standard extension"
    warn NonStandardExtensionWarning, msg
    modify_html('bordercolor', color)
  end

  def bordercolordark(color = nil)
    @bordercolordark ||= nil
    self.bordercolordark = color if color
    @bordercolordark
  end

  def bordercolordark=(color)
    @bordercolordark = color
    msg = "'bordercolordark' is a non-standard extension"
    warn NonStandardExtensionWarning, msg
    modify_html('bordercolordark', color)
  end

  def bordercolorlight(color = nil)
    @bordercolorlight ||= nil
    self.bordercolorlight = color if color
    @bordercolorlight
  end

  def bordercolorlight=(color)
    @bordercolorlight = color
    msg = "'bordercolorlight' is a non-standard extension"
    warn NonStandardExtensionWarning, msg
    modify_html('bordercolorlight', @bordercolorlight)
  end

  def cellpadding(num = nil)
    @cellpadding ||= nil
    self.cellpadding = num if num
    @cellpadding
  end

  def cellpadding=(num)
    raise ArgumentError if num.to_i < 0
    @cellpadding = num.to_i
    modify_html('cellpadding', @cellpadding)
  end

  def cellspacing(num = nil)
    @cellspacing ||= nil
    self.cellspacing = num if num
    @cellspacing
  end

  def cellspacing=(num)
    raise ArgumentError if num.to_i < 0
    @cellspacing = num.to_i
    modify_html('cellspacing', @cellspacing)
  end

  def char(character = nil)
    @char ||= nil
    self.char = character if character
    @char
  end

  def char=(character)
    raise ArgumentError if character.to_s.length > 1
    @char = character.to_s
    modify_html('char', character.to_s)
  end

  def charoff(offset = nil)
    @charoff ||= nil
    self.charoff = offset if offset
    @charoff
  end

  def charoff=(offset)
    raise ArgumentError if offset.to_i < 0
    @charoff = offset
    modify_html('charoff', offset)
  end

  # Returns the CSS class. The trailing underscore is necessary in order
  # to avoid conflict with the 'class' keyword.
  #
  def class_(klass = nil)
    @class ||= nil
    self.class_ = klass if klass
    @class
  end

  # Returns the CSS class.  The trailing underscore is necessary in order
  # to avoid conflict with the 'class' keyword.
  #
  def class_=(klass)
    modify_html('class', klass)
    @class = klass
  end

  def col(num = nil)
    @col ||= nil
    self.col = num if num
    @col
  end

  def col=(num)
    raise ArgumentError if num.to_i < 0
    @col = num.to_i
    modify_html('col', @col)
  end

  def colspan(span = nil)
    @colspan ||= nil
    self.colspan = span if span
    @colspan
  end

  def colspan=(span)
    raise ArgumentError if span.to_i < 0
    @colspan = span.to_i
    modify_html('colspan', @colspan)
  end

  # Allows you to configure various attributes by row or row + column.
  #
  def configure(row, col = nil)
    if col
      begin
        yield self[row][col]
      rescue NameError
        msg = 'No column to configure in a ' + self.class.to_s + ' class'
        raise ArgumentError, msg
      end
    else
      yield self[row]
    end
  end

  # Returns the HTML content (i.e. text).
  #
  def content(arg = nil, &block)
    case arg
    when String
      self.content = Table::Content.new(arg, &block)
    when Array
      arg.each do |e|
        if e.is_a?(Array)
          row = Table::Row.new
          e.each { |element| row.push(Table::Content.new(element, &block)) }
          push(row)
        else
          self.content = Table::Content.new(e, &block)
        end
      end
    else
      self.content = arg if arg
    end
    @html_body
  end

  alias data content

  def frame(type = nil)
    @frame ||= nil
    self.frame = type if type
    @frame
  end

  def frame=(type)
    valid = %w[border void above below hsides lhs rhs vsides box]
    raise ArgumentError unless valid.include?(type.downcase)
    @frame = type
    modify_html('frame', @frame)
  end

  def height(num = nil)
    @height ||= nil
    self.height = num if num
    @height
  end

  def height=(num)
    raise ArgumentError if num.to_i < 0
    @height = num.to_i
    modify_html('height', @height)
  end

  def hspace(num = nil)
    @hspace ||= nil
    self.hspace = num if num
    @hspace
  end

  def hspace=(num)
    raise ArgumentError if num.to_i < 0
    @hspace = num.to_i
    modify_html('hspace', @hspace)
  end

  def nowrap(bool = nil)
    @nowrap ||= nil
    self.nowrap = bool if bool
    @nowrap
  end

  def nowrap=(bool)
    raise TypeError unless bool.is_a?(TrueClass) || bool.is_a?(FalseClass)
    @nowrap = bool
    modify_html('nowrap', @nowrap)
  end

  def rowspan(num = nil)
    @rowspan ||= nil
    self.rowspan = num if num
    @rowspan
  end

  def rowspan=(num)
    raise ArgumentError if num.to_i < 0
    @rowspan = num.to_i
    modify_html('rowspan', @rowspan)
  end

  def rules(edges = nil)
    @rules ||= nil
    self.rules = edges if edges
    @rules
  end

  def rules=(edges)
    valid = %w[all groups rows cols none]
    raise ArgumentError unless valid.include?(edges.to_s.downcase)
    @rules = edges
    modify_html('rules', @rules)
  end

  def span(num = nil)
    @span ||= nil
    self.span = num if num
    @span
  end

  def span=(num)
    raise ArgumentError if num.to_i < 0
    @span = num.to_i
    modify_html('span', @span)
  end

  def style(string = nil)
    @style ||= nil
    self.style = string if string
    @style
  end

  def style=(string)
    @style = string.to_s
    modify_html('style', @style)
  end

  def summary(string = nil)
    @summary ||= nil
    self.summary = string if string
    @summary
  end

  def summary=(string)
    @summary = string.to_s
    modify_html('summary', @summary)
  end

  def valign(position = nil)
    @valign ||= nil
    self.valign = position if position
    @valign
  end

  def valign=(position)
    valid = %w[top center bottom baseline]
    raise ArgumentError unless valid.include?(position.to_s.downcase)
    @valign = position
    modify_html('valign', @valign)
  end

  def vspace(num = nil)
    @vspace ||= nil
    self.vspace = num if num
    @vspace
  end

  def vspace=(num)
    raise ArgumentError if num.to_i < 0
    @vspace = num.to_i
    modify_html('vspace', @vspace)
  end

  def width(num = nil)
    @width ||= nil
    self.width = num if num
    @width
  end

  def width=(num)
    if num =~ /%/
      @width = num
    else
      raise ArgumentError if num.to_i < 0
      @width = num.to_i
    end
    modify_html('width', @width)
  end
end
