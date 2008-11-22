require 'test/unit'
require 'array_ordinal_accessor'

class TestArrayOrdinalAccessor < Test::Unit::TestCase
  def test_to_alphabetic
    assert_to_alphabetic 'zero', 0
    assert_to_alphabetic 'two', 2
    assert_to_alphabetic 'twelve', 12
    assert_to_alphabetic 'twenty two', 22
    assert_to_alphabetic 'two hundred and twenty two', 222
    assert_to_alphabetic 'two hundred and twenty', 220
    assert_to_alphabetic 'two thousand two hundred and twenty two', 2222
    assert_to_alphabetic 'twenty two thousand two hundred and twenty two', 22222
  end

  def test_from_alphabetic
    assert_from_alphabetic 0, 'zero'
    assert_from_alphabetic 2, 'two'
    assert_from_alphabetic 12, 'twelve'
    assert_from_alphabetic 22, 'twenty two'
    assert_from_alphabetic 222, 'two hundred and twenty two'
    assert_from_alphabetic 220, 'two hundred and twenty'
    assert_from_alphabetic 2222, 'two thousand two hundred and twenty two'
    assert_from_alphabetic 22222, 'twenty two thousand two hundred and twenty two'
  end

  def test_to_ordinal
    assert_raise(StandardError) do 0.to_ordinal end
    assert_to_ordinal 'second', 2
    assert_to_ordinal 'twelveth', 12
    assert_to_ordinal 'twentieth', 20
    assert_to_ordinal 'twenty second', 22
  end

  def test_from_ordinal
    assert_from_ordinal 2, 'second'
    assert_from_ordinal 12, 'twelveth'
    assert_from_ordinal 20, 'twentieth'
    assert_from_ordinal 22, 'twenty second'
  end

  def assert_to_alphabetic(expect, num)
    assert_equal expect, num.to_alphabetic
  end

  def assert_from_alphabetic(expect, str)
    assert_equal expect, Integer.from_alphabetic(str)
  end

  def assert_to_ordinal(expect, num)
    assert_equal expect, num.to_ordinal
  end

  def assert_from_ordinal(expect, str)
    assert_equal expect, Integer.from_ordinal(str)
  end
end
