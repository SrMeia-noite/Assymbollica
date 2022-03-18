class Token
    def initialize
        @type  = nil
        @value = nil
        
        @absolute_position = nil
        @relative_position = nil
        @line_number       = nil
        
        self
    end

    def set_type type
        @type = type
        self
    end

    def set_value value
        @value = value
        self
    end

    def set_absolute_position absolute_position
        @absolute_position = absolute_position
        self
    end

    def set_relative_position relative_position
        @relative_position = relative_position
        self
    end

    def set_line_number line_number
        @line_number = line_number
        self
    end

    def match other
        ( other  .is_a? Token       ) && \
        ( @type  .eql?  other.type  ) && \
        ( @value .eql?  other.value )
    end

    def to_s
        "{ type: '#@type', value: '#@value', position: (#@relative_position:#@line_number:#@absolute_position) }"
    end
end