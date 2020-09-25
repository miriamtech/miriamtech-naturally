require_relative './naturally/tokenizer'
require_relative './core_ext/string'

module Naturally
  def Naturally.tokens(string)
    Tokenizer.new(string).tokens
  end

  def Naturally.compare(a, b)
    atokens = a.natural_tokens
    btokens = b.natural_tokens
    for i in (0..[atokens.size, btokens.size].min-1)
      avalue = atokens[i]
      bvalue = btokens[i]
      if avalue.nil?
        return -1
      elsif bvalue.nil?
        return 1
      end
      comparison_results = avalue <=> bvalue
      if comparison_results.nil?
        comparison_results = avalue.to_s <=> bvalue.to_s
      end
      if comparison_results != 0
        return comparison_results
      end
    end
    0
  end
end
