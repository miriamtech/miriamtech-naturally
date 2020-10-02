require 'minitest/autorun'
require_relative '../lib/naturally'

class NaturallyTest < Minitest::Test
  def test_tokens_sort
    tokens = 'I have 8 chickens and 0 cows and 16 children'.natural_tokens.collect(&:value)
    assert_equal(
      ['I', 'have', 8, 'chickens', 'and', 0, 'cows', 'and', 16, 'children'],
      tokens
    )
    tokens = '1.2.3.12.23.45'.natural_tokens.collect(&:value)
    assert_equal(
      [1, '.', 2, '.', 3, '.', 12, '.', 23, '.', 45],
      tokens
    )
    assert_equal ['Block', 10], 'Block 10'.natural_tokens.collect(&:value)
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

  def test_sort_by_tokens
    objects = [
      OpenStruct.new(name: 'Block 65'),
      OpenStruct.new(name: '65 Blocks'),
      OpenStruct.new(name: 'Block 66'),
      OpenStruct.new(name: '66 Blocks'),
      OpenStruct.new(name: 'And something really long with 8 tokens')
    ]
    assert_equal [objects[1], objects[3], objects[4], objects[0], objects[2]], objects.sort_by { |o| Naturally.tokens(o.name) }
  end
end
