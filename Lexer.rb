( require_relative 'Token.rb' )
( require_relative 'Rule.rb'  )

class Lexer
    def initialize
        @string = nil
        @rules  = [ ]
        self
    end

    def add_rule rule
        @rules << rule
        self
    end

    def add_content string
        @string = string
        self
    end

    def lex
        token   = nil
        tokens  = [ ]
        cursor  =  0
        relcur  =  0
        lineno  =  0
        retries =  0
        full    = false

        string_length = @string.length

        until (retries .eql? @rules.length) do

            retries = 0

            @rules.each { |rule|
                
                (full = cursor .eql? string_length) \
                    && (tokens << Token.new.set_type(:EOI).set_value("<EOI>"); break)

                match = @string[cursor...string_length].match rule.rule

                ( match .eql? nil  ) && ( retries += 1 ; next        )
                ( match .eql? "\n" ) && ( relcur   = 0 ; lineno += 1 )

                match        = match.to_s
                match_length = match.length
 
                (rule.type .eql? :ignore) || (
                    tokens << Token.new.set_type(rule.type)
                                       .set_value(match)
                                       .set_absolute_position(cursor)
                                       .set_relative_position(relcur)
                                       .set_line_number(lineno)
                )

                cursor += match_length
                relcur += match_length
                break
            }
            
            (full) && (return tokens)
        end

        raise "Error: Unknown token '#{@string[cursor]}' at (#{lineno}:#{relcur}:#{cursor})."
    end
end