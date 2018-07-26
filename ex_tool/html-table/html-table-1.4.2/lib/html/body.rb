module HTML
  # This class represents an HTML table body (<tbody>).  It is a
  # subclass of Table::TableSection.
  #
  class Table::Body < Table::TableSection
    @indent_level = 3
    @end_tags     = true

    # Returns a new Table::Body object.  Optionally takes a block.  If
    # an argument is provided, it is treated as content.
    #
    def initialize(arg = nil, &block)
      @html_begin = '<tbody'
      @html_end   = '</tbody>'
      instance_eval(&block) if block_given?
      self.content = arg if arg
    end

    # Returns a boolean indicating whether or not end tags, </tbody>, are
    # included for each Body object in the final HTML output.  The
    # default is true.
    #
    def self.end_tags?
      @end_tags
    end

    # Sets whether or not end tags are included for each Body object in
    # the final HTML output.  The default is true.  Only true or false are
    # valid arguments.
    #
    def self.end_tags=(bool)
      expect(bool, [TrueClass, FalseClass])
      @end_tags = bool
    end
  end
end
