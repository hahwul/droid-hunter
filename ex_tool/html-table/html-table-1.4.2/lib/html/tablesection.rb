module HTML
  # Superclass for THEAD, TBODY, TFOOT
  #
  class Table::TableSection < Array
    include AttributeHandler
    include HtmlHandler

    def initialize(&block)
      instance_eval(&block) if block_given?
    end

    # Adds a Table::Row object as content. The +arg+ is passed as the value
    # to the Table::Row constructor.
    #
    def content=(arg)
      tr = Table::Row.new(arg)
      push(tr)
    end

    class << self
       attr_reader :indent_level
     end

    def self.indent_level=(num)
      expect(num, Integer)
      raise ArgumentError, 'indent_level must be >= 0' if num < 0
      @indent_level = num
    end

    def []=(index, obj)
      expect(obj, Table::Row)
      super
    end

    def push(*args)
      args.each { |obj| expect(obj, Table::Row) }
      super
    end

    def unshift(obj)
      expect(obj, Table::Row)
      super
    end

    alias to_s html
    alias to_str html
  end
end
