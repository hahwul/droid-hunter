module HTML
  # This class represents an HTML column group (<colgroup>).  It is a
  # subclass of Array.  The only elements it may contain are instances
  # of the ColGroup::Col class.
  #
  class Table::ColGroup < Array
    include AttributeHandler
    include HtmlHandler

    @indent_level = 3
    @end_tags     = true

    undef_method :content

    # Returns a new ColGroup object. Optionally takes a block. If an
    # argument is provided, it is treated as content.
    #
    def initialize(arg = nil, &block)
      @html_begin = '<colgroup'
      @html_body  = ''
      @html_end   = '</colgroup>'
      instance_eval(&block) if block_given?
      push(arg) if arg
    end

    # Returns the indentation level for the tags of this class.  The
    # default is 3.
    #
    class << self
       attr_reader :indent_level
     end

    # Sets the indentation level for the tags of this class.  The default
    # is 3.
    #
    def self.indent_level=(num)
      expect(num, Integer)
      raise ArgumentError, 'indent_level must be >= 0' if num < 0
      @indent_level = num
    end

    # This method has been redefined to only allow ColGroup::Col objects
    # to be assigned.
    #
    def []=(index, obj)
      if obj.is_a?(Array)
        expect(obj.first, Col) # In case of 0 length Array
        obj.each do |o|
          expect(o, Col)
        end
      else
        expect(obj, Col)
      end
      super
    end

    # This method has been redefined to only allow ColGroup::Col objects
    # to be pushed onto a ColGroup instance.
    #
    def push(*args)
      args.each do |obj|
        unless obj.is_a?(Table::ColGroup::Col)
          msg = 'Can only assign Col objects to ColGroup class'
          msg += ': ' + obj.class.to_s
          raise TypeError, msg
        end
        super(obj)
      end
    end

    # This method has been redefined to only allow ColGroup::Col objects
    # to be pushed onto a ColGroup instance.
    #
    def <<(obj)
      unless obj.is_a?(Table::ColGroup::Col)
        msg = 'Can only assign Col objects to ColGroup class'
        msg += ': ' + obj.class.to_s
        raise TypeError, msg
      end
      super(obj)
    end

    # This method has been redefined to only allow ColGroup::Col objects
    # to be unshifted onto a ColGroup instance.
    #
    def unshift(obj)
      unless obj.is_a?(Table::ColGroup::Col)
        msg = 'Can only assign Data and Header objects to Row class'
        raise TypeError, msg
      end
      super
    end

    # Returns a boolean indicating whether or not end tags are included for
    # each ColGroup object in the final HTML output.  The default is true.
    #
    def self.end_tags?
      @end_tags
    end

    # Sets whether or not end tags are included for each ColGroup object in
    # the final HTML output.  The default is true.  Only true or false are
    # valid arguments.
    #
    def self.end_tags=(bool)
      expect(bool, [TrueClass, FalseClass])
      @end_tags = bool
    end

    alias to_s html
    alias to_str html
  end
end
