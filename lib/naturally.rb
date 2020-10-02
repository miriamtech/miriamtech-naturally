require_relative './naturally/tokenizer'
require_relative './naturally/comparable_token'
require_relative './core_ext/string'

module Naturally
  def Naturally.tokens(string)
    Tokenizer.new(string).tokens
  end

  def Naturally.compare(a, b)
    atokens = a.natural_tokens
    btokens = b.natural_tokens
    for i in (0..[atokens.size, btokens.size].min-1)
      comparison_results = atokens[i] <=> btokens[i]
      if comparison_results != 0
        return comparison_results
      end
    end
    0
  end
end
