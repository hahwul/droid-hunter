module HTML
  # This class represents an HTML Caption.  Despite the name, it is not
  # a subclass of Table.  Note that end tags for this class are mandatory.
  #
  class Table::Caption
    include AttributeHandler
    include HtmlHandler

    undef_method :configure
    @indent_level = 3

    # Returns a new Table::Caption object.  Optionally takes a block.  If
    # an argument is provided it is treated as content.
    #
    def initialize(arg = nil, &block)
      @html_begin = '<caption'
      @html_body  = ''
      @html_end   = '</caption>'
      instance_eval(&block) if block_given?
      self.content = arg if arg
    end

    # Adds content to the Table::Caption object.
    #
    def content=(arg)
      arg = arg.is_a?(Array) ? arg.join : arg.to_s
      @html_body = Table::Content.new(arg)
    end

    # Returns the number of spaces that tags for this class are indented.
    # For the Table::Caption class, the indention level defaults to 3.
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

    alias to_s html
    alias to_str html
  end
end
