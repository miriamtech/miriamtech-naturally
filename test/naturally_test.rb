require 'minitest/autorun'
require_relative '../lib/naturally'

class NaturallyTest < Minitest::Test
  def test_natural_tokens
    tokens = 'I have 8 chickens and 0 cows and 16 children'.natural_tokens
    assert_equal(
      ['I', 'have', 8, 'chickens', 'and', 0, 'cows', 'and', 16, 'children'],
      tokens
    )
    tokens = '1.2.3.12.23.45'.natural_tokens
    assert_equal(
      [1, '.', 2, '.', 3, '.', 12, '.', 23, '.', 45],
      tokens
    )
    assert_equal ['Block', 10], 'Block 10'.natural_tokens
  end

  def test_sorting
    assert_equal(
      ['a1', 'a2', 'a2.0', 'a12', 'b1', 'b2', 'b13'],
      ['a1', 'a2', 'a12', 'a2.0', 'b13', 'b2', 'b1'].sort(&:naturally)
    )
    assert_equal(
      ['Block 1', 'Block 2', 'Block 3', 'Block 10', 'Block 30'],
      ['Block 10', 'Block 1', 'Block 3', 'Block 2', 'Block 30'].sort(&:naturally)
    )
    assert_equal(
      ['1st Ave', '3rd Street', 'Second Street'],
      ['Second Street', '1st Ave', '3rd Street'].sort(&:naturally)
    )
    assert_equal(
      ['Strings', 'of different lengths'],
      ['of different lengths', 'Strings'].sort(&:naturally)
    )
    assert_equal(
      ['a.1.a', 'a.1.a.1'],
      ['a.1.a.1', 'a.1.a'].sort(&:naturally)
    )
  end
end
