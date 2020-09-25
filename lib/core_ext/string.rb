class String
  def natural_tokens
    Naturally.tokens(self)
  end

  def naturally(another_string)
    Naturally.compare(self, another_string)
  end
end
