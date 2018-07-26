module HTML
  # This class represents an HTML table header (<th>).  Despite the name
  # it is not a subclass of Table or Table::Row.
  #
  class Table::Row::Header
    include AttributeHandler
    include HtmlHandler

    undef_method :configure

    @indent_level = 6
    @end_tags     = true

    # Creates and returns a new Header object.  Optionally takes a block.
    # If an argument is provided, it is treated as content.
    #
    def initialize(arg = nil, &block)
      @html_begin = '<th'
      @html_body  = ''
      @html_end   = '</th>'
      instance_eval(&block) if block_given?
      self.content = arg if arg
    end

    # Adds content to the Table::Row::Header object.
    #
    def content=(arg)
      arg = arg.is_a?(Array) ? arg.join : arg.to_s
      @html_body = Table::Content.new(arg)
    end

    # Returns the indentation level for the tags of this class.  The
    # default is 6.
    #
    class << self
      attr_reader :indent_level
    end

    # Sets the indentation level for the tags of this class.  The default
    # is 6.
    #
    def self.indent_level=(num)
      expect(num, Integer)
      raise ArgumentError, 'indent_level must be >= 0' if num < 0
      @indent_level = num
    end

    # Returns a boolean indicating whether or not end tags are included for
    # each Header object in the final HTML output.  The default is true.
    #
    def self.end_tags?
      @end_tags
    end

    # Sets whether or not end tags are included for each Header object in
    # the final HTML output.  The default is true.  Only true or false are
    # valid arguments.
    #
    def self.end_tags=(bool)
      expect(bool, [TrueClass, FalseClass])
      @end_tags = bool
    end
  end
end
