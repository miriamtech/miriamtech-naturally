module Naturally
  class Tokenizer
    def initialize(string)
      @string = string
    end

    def tokens
      @tokens = []
      @current = ''
      @string.chars.each do |c|
        if c =~ / /
          add_to_tokens
        else
          if c =~ /[0-9]/ and @current !~ /^[0-9]+$/
            add_to_tokens
          elsif c !~ /[0-9]/ and @current =~ /^[0-9]+$/
            add_to_tokens
          end
          @current += c
        end
      end
      add_to_tokens
      @tokens
    end

    private

    def add_to_tokens
      unless @current.empty?
        if @current =~ /^[0-9]+$/
          @tokens << ComparableToken.new(@current.to_i)
        else
          @tokens << ComparableToken.new(@current)
        end
      end
      @current = ''
    end
  end
end
