( require_relative 'Lexer.rb' )

module Assymbollica
    attr_accessor :lex, :lexer, :rules

    @lexer = Lexer.new
    @rules = [ # Needs to implement more tokens, these are just for testing
        Rule.new.from({ type: :ignore     , rule: /^(\s|\n)/                 }),
        Rule.new.from({ type: :identifier , rule: /^[a-zA-Z_]+[a-zA-Z0-9_]*/ }),
        Rule.new.from({ type: :integer    , rule: /^\d+/                     }),
        Rule.new.from({ type: :string     , rule: /^"[^"]*"/                 }),
        Rule.new.from({ type: :plus       , rule: /^\+/                      }),
        Rule.new.from({ type: :minus      , rule: /^\-/                      }),
        Rule.new.from({ type: :times      , rule: /^\*/                      }),
        Rule.new.from({ type: :over       , rule: /^\//                      }),
        Rule.new.from({ type: :assign     , rule: /^\=/                      }),
    ]
    @rules.each { |rule| @lexer.add_rule rule }

    def lex string
        (@lexer.add_content string).lex
    end

end; include Assymbollica

puts Assymbollica::lex "one_two_three_123 = 1 + 2 * 3 / 4"