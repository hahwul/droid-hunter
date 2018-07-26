module HTML
  class Table::Row < Array
    include AttributeHandler
    include HtmlHandler

    @indent_level = 3
    @end_tags     = true

    # Returns a new Table::Row object.  Optionally takes a block.  If +arg+
    # is provided it is treated as content.  If +header+ is false, that
    # content is transformed into a Row::Data object.  Otherwise, it is
    # converted into a Row::Header object.
    #
    # See the # Table::Row#content= method for more information.
    #--
    # Note that, despite the name, Row is a subclass of Array, not Table.
    #
    def initialize(arg = nil, header = false, &block)
      @html_begin = '<tr'
      @html_end = '</tr>'

      @header = header

      instance_eval(&block) if block_given?
      self.content = arg if arg
    end

    # Returns whether or not content is converted into a Row::Header object
    # (as opposed to a Row::Data object).
    #
    def header?
      @header
    end

    # Sets whether or not content is converted into a Row::Header object
    # or a Row::Data object.
    #
    attr_writer :header

    # Adds content to the Row object.
    #
    # Because a Row object doesn't store any of its own content, the
    # arguments to this method must be a Row::Data object, a Row::Header
    # object, or a String (or an array of any of these).  In the latter case,
    # a single Row::Data object is created for each string.
    #
    # Examples (with whitespace and newlines removed):
    #
    # row = Table::Row.new
    #
    # # Same as Table::Row.new('foo')
    # row.content = 'foo'
    # row.html => <tr><td>foo</td></tr>
    #
    # row.content = [['foo,'bar']]
    # row.html => <tr><td>foo</td><td>bar</td></tr>
    #
    # row.content = Table::Row::Data.new('foo')
    # row.html => <tr><td>foo</td></tr>
    #
    # row.content = Table::Row::Header.new('foo')
    # row.html => <tr><th>foo</th></tr>
    #
    def content=(arg)
      case arg
      when String
        if @header
          push(Table::Row::Header.new(arg))
        else
          push(Table::Row::Data.new(arg))
        end
      when Array
        arg.each do |e|
          if e.is_a?(Table::Row::Data) || e.is_a?(Table::Row::Header)
            push(e)
          else
            if @header
              push(Table::Row::Header.new(e))
            else
              push(Table::Row::Data.new(e))
            end
          end
        end
      else
        push(arg)
      end
    end

    # Returns the number of spaces that tags for this class are indented.
    # For the Row class, the indention level defaults to 3.
    #
    class << self
       attr_reader :indent_level
     end

    # Sets the number of spaces that tags for this class are indented.
    #
    def self.indent_level=(num)
      expect(num, Integer)
      raise ArgumentError if num < 0
      @indent_level = num
    end

    # Returns true or false, depending on whether or not the end tags for
    # this class, </tr>, are included for each row or not. By default, this
    # is set to true.
    #
    def self.end_tags?
      @end_tags
    end

    # Sets the behavior for whether or not the end tags for this class,
    # </tr>, are included for each row or not.  Only true and false are
    # valid arguments.
    #
    def self.end_tags=(bool)
      expect(bool, [TrueClass, FalseClass])
      @end_tags = bool
    end

    # This method has been redefined to only allow certain classes to be
    # accepted as arguments.  Specifically, they are Data and Header.  An
    # Array is also valid, but only if it only includes Data or Header
    # objects.
    #
    def []=(index, obj)
      if obj.is_a?(Array)
        obj.each { |o| expect(o, [Data, Header]) }
      else
        expect(obj, [Data, Header])
      end
      super
    end

    # This method has been redefined to only allow certain classes to be
    # accepted as arguments.  Specifically, they are String, Fixnum,
    # Data and Header.
    #
    # A plain string or number pushed onto a Row is automatically
    # converted to a Data object.
    #
    def push(*args)
      args.each do |obj|
        if obj.is_a?(String) || obj.is_a?(Integer)
          td = Table::Row::Data.new(obj.to_s)
          super(td)
          next
        else
          expect(obj, [Data, Header])
        end
        super(obj)
      end
    end

    # This method has been redefined to only allow certain classes to be
    # accepted as arguments.  The rules are the same as they are for
    # Row#push.
    #
    def <<(obj)
      if obj.is_a?(String) || obj.is_a?(Integer)
        td = Table::Row::Data.new(obj.to_s)
        super(td)
      else
        expect(obj, [Data, Header])
      end
      super(obj)
    end

    # This method has been redefined to only allow certain classes to be
    # accepted as arguments.  The rules are the same as they are for
    # Row#push.
    #
    def unshift(obj)
      if obj.is_a?(String) || obj.is_a?(Integer)
        td = Table::Row::Data.new(obj.to_s)
        super(td)
      else
        expect(obj, [Data, Header])
      end
      super(obj)
    end

    alias to_s html
    alias to_str html
  end
end
