require_relative 'attribute_handler'
require_relative 'html_handler'
require 'strongtyping'
require 'structured_warnings'
include StrongTyping

# Warning raised if a non-standard extension is used.
class NonStandardExtensionWarning < Warning; end

# Please, think of the children before using the blink tag.
class BlinkWarning < Warning; end

# The HTML module serves as a namespace only.
module HTML
  # The Table class encapsulates methods associated with an html table
  # element. It is the "outermost" class of the html-table classes.
  class Table < Array
    include AttributeHandler
    include HtmlHandler

    # The version of the html-table library
    VERSION = '1.4.2'.freeze

    # The indentation level for the <table> and </table> tags
    @indent_level = 0

    # The default character case used for printing output
    @html_case = 'lower'

    # Determines whether or not end tags will be included in printed output
    @@global_end_tags = true

    # Returns a new Table object. Optionally takes a block which is
    # eval'd if provided. If an argument is provided it is interpreted as
    # content. See the Table#content= method for how that data will be
    # interpreted.
    #
    # Examples:
    #
    #    # A single data item
    #    HTML::Table.new(1).html
    #
    #    # Output
    #    <table>
    #       <tr>
    #          <td>1</td>
    #       </tr>
    #    </table>
    #
    #    # One row per data item
    #    HTML::Table.new(['Matz', 'Larry', 'Guido']).html
    #
    #    # Output
    #    <table>
    #       <tr>
    #          <td>Matz</td>
    #       </tr>
    #       <tr>
    #          <td>Larry</td>
    #       </tr>
    #       <tr>
    #          <td>Guido</td>
    #       </tr>
    #       </tr>
    #    </table>
    #
    #    # Multiple data items per row
    #    Table.new{ |t|
    #       t.content = [['a','b'], [1,2], ['x','y']]
    #    }.html
    #
    #    # Output
    #    <table>
    #       <tr>
    #          <td>a</td>
    #          <td>b</td>
    #       </tr>
    #       <tr>
    #          <td>1</td>
    #          <td>2</td>
    #       </tr>
    #       <tr>
    #          <td>x</td>
    #          <td>y</td>
    #       </tr>
    #    </table>
    #
    def initialize(arg = nil, html_options = {}, &block)
      @html_begin = '<table'
      @html_body  = ''
      @html_end   = '</table>'
      instance_eval(&block) if block
      self.content = arg if arg

      # Assume html_options are attributes
      html_options.each  do |key, val|
        send("#{key}=", val)
      end
    end

    # Adds content to the table. How this method behaves depends on the
    # type of argument being passed.
    #
    # The +arg+ may be a Table::Row object, an Array of Table::Row objects,
    # an Array of Array's, an Array of Strings, or a single String.  In the
    # last two cases, a single Table::Row with a single Table::Row::Data
    # object is created, with the string as the content.
    #
    def content=(arg)
      if arg.is_a?(Array)
        arg.each { |e| self << Table::Row.new(e) }
      else
        self << Table::Row.new(arg)
      end
    end

    alias data= content=

    # A shortcut for creating Table::Row::Header objects in the constructor
    # using the DSL style syntax.
    #
    def header(arg = nil)
      self.header = arg if arg
    end

    # Adds a Table::Row::Header object (or an Array of them) to the Table
    # object.
    #
    def header=(arg)
      if arg.is_a?(Array)
        arg.each { |h| self << Table::Row.new(h, true) }
      else
        self << Table::Row::Header.new(arg)
      end
    end

    # Returns true or false, depending on whether or not end tags have been
    # turned on or off, respectively.
    #
    def self.global_end_tags?
      @@global_end_tags
    end

    # Sets the end tag class variable.  This is used to set whether or not
    # to include optional end tags in the final HTML output.  The argument
    # sent to this method must be true or false.  The default value is true.
    #
    # Note that mandatory end tags are unaffected by this setting.
    #
    def self.global_end_tags=(bool)
      expect(bool, [TrueClass, FalseClass])
      @@global_end_tags = bool
    end

    # Returns either "lower" or "upper", indicating the case of all HTML
    # tags in the final output.
    #
    class << self
      attr_reader :html_case
    end

    # Sets the case of all HTML tags to either lower or upper.  The only
    # valid arguments to this method are 'upper' or 'lower'.
    #
    def self.html_case=(arg)
      expect(arg, String)
      arg.downcase!
      unless arg == 'upper' || arg == 'lower'
        msg = "Argument to html_case() must be 'upper' or 'lower'"
        raise ArgumentError, msg
      end
      @html_case = arg
    end

    # Returns the number of spaces that tags for this class are indented.
    # For the Table class, the indention level defaults to 0.
    #
    # Note that each class has its own default indentation level (a multiple
    # of 3).
    #
    class << self
      attr_reader :indent_level
    end

    # Sets the number of spaces that tags for this class are indented.
    #
    def self.indent_level=(num)
      expect(num, Integer)
      raise ArgumentError, 'indent level must be >= 0' if num < 0
      @indent_level = num
    end

    # This method has been redefined to only allow certain subclasses to
    # be assigned using a direct index notation.  Specifically, only
    # Caption, ColGroup, Body, Foot, Head and Row objects may be use
    # assigned using direct index notation.
    #
    # In addition, a Caption can only be assigned to index 0.  A Head can
    # only be assigned to index 0, or index 1 if a Caption already exists.
    # A Foot may only be assigned as the last element.
    #
    def []=(index, obj)
      expect(obj, [Caption, ColGroup, Body, Foot, Head, Row])

      # Only allow Caption objects at index 0
      if index != 0 && obj.is_a?(HTML::Table::Caption)
        msg = 'CAPTION can only be added at index 0'
        raise ArgumentError, msg
      end

      # Only allow Head objects at index 0 or 1
      if obj.is_a?(HTML::Table::Head)
        if self[0].is_a?(HTML::Table::Caption) && index != 1
          msg = 'THEAD must be at index 1 when Caption is included'
          raise ArgumentError, msg
        end

        if !self[0].is_a?(HTML::Table::Caption) && index != 0
          msg = 'THEAD must be at index 0 when no Caption is included'
          raise ArgumentError, msg
        end
      end

      if obj.is_a?(HTML::Table::Foot) && index != -1
        msg = 'FOOT must be last element'
        raise ArgumentError, msg
      end

      super
    end

    # This method has been redefined to only allow certain subclasses to
    # be accepted as arguments.  Specifically, only Caption, ColGroup,
    # Body, Foot, Head, Row, Row::Data and Row::Header objects may be
    # pushed onto a Table.
    #
    # Pushing a Data or Header object onto a Table object creates its own
    # row for each.  If a Caption object is pushed onto the Table, it will
    # automatically be bumped to the first element.  If a Head object is
    # pushed onto the Table, it is automatically bumped to the first
    # element, or the second element if a Caption already exists.
    #
    def push(*args)
      args.each do |obj|
        expect(obj, [Caption, ColGroup, Body, Foot, Head, Row, Row::Data, Row::Header])

        case obj
        when Table::Row::Data, Table::Row::Header
          push(Table::Row.new(obj))
        when Table::Caption
          if self[0].is_a?(Table::Caption)
            self[0] = obj
          else
            unshift(obj)
          end
        when Table::Head
          if self[0].is_a?(Table::Caption)
            unshift(obj)
            self[0], self[1] = self[1], self[0]
          else
            unshift(obj)
          end
        else
          super(obj)
        end
      end
    end

    # This method has been redefined to only allow certain subclasses to
    # be accepted as arguments.
    #
    # The restrictions and behavior are identical to the push() method.
    #
    def <<(obj)
      expect(obj, [Caption, ColGroup, Body, Foot, Head, Row, Row::Data, Row::Header])

      case obj
      when Table::Row::Data, Table::Row::Header # Each get their own row
        self << Table::Row.new(obj)
      when Table::Caption                       # Always the first row
        if self[0].is_a?(Table::Caption)
          self[0] = obj
        else
          unshift(obj)
        end
      when Table::Head                          # Always at row 0 or 1
        if self[0].is_a?(Table::Caption)
          unshift(obj)
          self[0], self[1] = self[1], self[0]
        else
          unshift(obj)
        end
      else
        super(obj)
      end
    end

    # This method has been redefined to only allow certain subclasses to
    # be unshifted onto a Table object.  Specifically, they are Caption,
    # ColGroup, Body, Foot, Head and Row.
    #
    def unshift(obj)
      expect(obj, [Caption, ColGroup, Body, Foot, Head, Row])
      super
    end

    alias to_s html
    alias to_str html
  end
end

require_relative 'content'
require_relative 'caption'
require_relative 'colgroup'
require_relative 'col'
require_relative 'row'
require_relative 'header'
require_relative 'data'
require_relative 'tablesection'
require_relative 'head'
require_relative 'foot'
require_relative 'body'
