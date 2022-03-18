class Rule
    attr_accessor :type, :rule

    def initialize
        @type = nil
        @rule = nil
    end

    def set_type type
        @type = type
        self
    end

    def set_rule rule
        @rule = rule
        self
    end

    def from set
        self.set_type(set[:type]).set_rule(set[:rule])
    end

    def to_s
        "(#@type => #@rule)"
    end
end