module Naturally
  class ComparableToken
    attr_reader :value

    def initialize(value)
      @value = value
    end

    def <=>(another)
      if value.nil?
        return -1
      elsif another.value.nil?
        return 1
      end
      comparison_results = value <=> another.value
      if comparison_results.nil?
        comparison_results = value.to_s <=> another.value.to_s
      end
      comparison_results
    end
  end
end
