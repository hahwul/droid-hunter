module HtmlHandler
  $upper = false

  # Used on HTML attributes. It creates proper HTML text based on the argument
  # type.  A string looks like "attr='text'", a number looks like "attr=1",
  # while a true value simply looks like "attr" (no equal sign).
  #--
  # This is private method.
  #
  def modify_html(attribute, arg = nil)
    if @html_begin.scan(/\b#{attribute}\b/).empty?
      @html_begin << if arg.is_a?(Integer)
                       " #{attribute}=#{arg}"
                     elsif arg.is_a?(TrueClass)
                       " #{attribute}"
                     else
                       " #{attribute}='#{arg}'"
                     end
    else
      if arg.is_a?(Integer)
        @html_begin.gsub!(/#{attribute}=\d+/, "#{attribute}=#{arg}")
      elsif arg.is_a?(FalseClass)
        @html_begin.gsub!(/#{attribute}/, '')
      else
        @html_begin.gsub!(/#{attribute}=['\w\.]+/, "#{attribute}='#{arg}'")
      end
    end
  end

  # Returns the HTML text for the current object.  Indentation and end tag
  # options are optional, based on the settings of the classes themselves.
  #
  # If +formatting+ is false, then formatting and whitespace is not applied
  # and you will get a single, very long string.  Note that case is still
  # honored.
  #
  def html(formatting = true)
    if self.class.respond_to?(:html_case)
      $upper = true if self.class.html_case == 'upper'
    end

    if $upper
      @html_begin.upcase!
      @html_end.upcase!
    end

    ilevel = 0

    if formatting && self.class.respond_to?(:indent_level)
      ilevel = self.class.indent_level
    end

    html          = ' ' * ilevel + @html_begin[0..-1]
    len           = html.length
    html[len, len] = '>'

    html << if is_a?(Array)
              if formatting
                map { |e| "\n" + e.html(formatting).to_s }.join
              else
                map { |e| e.html(formatting).to_s }.join
                      end
            else
              @html_body
            end

    #####################################################################
    # Add end tags, or not, depending on whether the class supports the
    # end_tags class method.  Those that don't have an end_tags class
    # method necessarily means that the end tag must be included.
    #
    # The Table.global_end_tags method overrides the individual class
    # preferences with regards to end tags.
    #####################################################################
    if is_a?(Array)
      if HTML::Table.global_end_tags?
        if self.class.respond_to?(:end_tags?)
          if formatting
            html << "\n" + (' ' * ilevel) + @html_end if self.class.end_tags?
          else
            html << (' ' * ilevel) + @html_end if self.class.end_tags?
          end
        else
          html << if formatting
                    "\n" + (' ' * ilevel) + @html_end
                  else
                    (' ' * ilevel) + @html_end
                  end
        end
      else
        unless self.class.respond_to?(:end_tags?)
          html << if formatting
                    "\n" + (' ' * ilevel) + @html_end
                  else
                    (' ' * ilevel) + @html_end
                  end
        end
      end
    else
      if HTML::Table.global_end_tags?
        if self.class.respond_to?(:end_tags?)
          html << @html_end if self.class.end_tags?
        else
          html << @html_end
        end
      else
        html << @html_end unless self.class.respond_to?(:end_tags?)
      end
    end

    html
  end

  private :modify_html
end
