# ref.
# http://masaji.at.webry.info/200809/article_127.html
# http://ja.wikipedia.org/wiki/%E5%91%BD%E6%95%B0%E6%B3%95

module ArrayOrdinalAccessor
  VERSION = '0.0.1'
end

class Integer
  LESS_THAN_20 = [
    :zero,    :one,     :two,       :three,    :four, 
    :five,    :six,     :seven,     :eight,    :nine, 
    :ten,     :eleven,  :twelve,    :thirteen, :fourteen, 
    :fifteen, :sixteen, :seventeen, :eighteen, :nineteen, 
  ]
  DOUBLE_FIGURES = [
    nil,    :ten,   :twenty,  :thirty, :forty, 
    :fifty, :sixty, :seventy, :eighty, :ninety
  ]
  HUNDRED = :hundred
  BIG_FIGURES = [
    nil,                    :thousand,             :million,          :billion,             :trillion,
    :quadrillion,           :quintillion,          :sextillion,       :septillion,          :octillion,
    :nonillion,             :decillion,            :undecillion,      :duodecillion,        :tredecillion,
    :quattuordecillion,     :quindecillion,        :sexdecillion,     :septendecillion,     :octodecillion,
    :novemdecillion,        :vigintillion,         :unvigintillion,   :duovigintillion,     :tresvigintillion,
    :quattuorvigintillion,  :quinquavigintillion,  :sesvigintillion,  :septemvigintillion,  :octovigintillion,
    :novemvigintillion,     :trigintillion,        :untrigintillion,  :duotrigintillion,    :trestrigintillion,
    :quattuortrigintillion, :quinquatrigintillion, :sestrigintillion, :septentrigintillion, :octotrigintillion,
    :noventrigintillion,
  ]
  AND = :and

  SPECIAL_ORDINALS = [
    nil,    :first, :second, :third,  nil, 
    :fifth, nil,    nil,     :eighth, :ninth,
  ]
  DOUBLE_FIGURES[2..-1].each_with_index do |fig, i|
    SPECIAL_ORDINALS[(i+2) * 10] = :"#{fig.to_s[0..-2]}ieth"
  end

  class <<self
    def from_alphabetic(str, sep=' ')
      ret, tmp = 0, 0
      (str.is_a?(String) ? str.split(sep) : str).map{|e| e.to_sym}.each do |num|
        case num
        when NilClass, AND;   # ignore
        when *LESS_THAN_20;   tmp += LESS_THAN_20.index num
        when *DOUBLE_FIGURES; tmp += DOUBLE_FIGURES.index(num) * 10
        when HUNDRED;         tmp *= 100
        when *BIG_FIGURES;    ret += tmp * 1000**BIG_FIGURES.index(num); tmp = 0
        else;                 raise ArgumentError.new("Invalid Format: #{num}")
        end
      end
      ret + tmp
    end

    def from_ordinal(str, sep=' ')
      array = (str.is_a?(String) ? str.split(sep) : str).map{|e| e.to_sym}
      array[-1] =
        if SPECIAL_ORDINALS.include?(array.last)
          if (idx = SPECIAL_ORDINALS.index(array.last)) < 20
            LESS_THAN_20[idx]
          else
            array.last.to_s.sub(/ieth$/, 'y').to_sym
          end
        else
          array[-1].to_s[0...-2].to_sym
        end
      from_alphabetic array
    end

    def alphabetic_max
      BIG_FIGURES.inject('') do |ret, fig|
        fig ?
          "nine_hundred_ninety_nine_#{fig}_#{ret}" :
          "nine_hundred_and_ninety_nine"
      end
    end

    def ordinal_max
      alphabetic_max.sub(/nine$/, 'ninth')
    end
  end

  def to_alphabetic(sep=' ')
    to_alphabetic_array.join sep
  end

  def to_ordinal(sep=' ')
    raise StandardError.new('Zero is not ordinal') if self == 0
    to_ordinal_array.join sep
  end

  private

  def to_alphabetic_array
    return [:zero] if self == 0

    triples = []
    num = self
    while num != 0
      triples << num % 1000
      num /= 1000
    end
    raise RangeError.new('Too large') if BIG_FIGURES.size < triples.size

    ret = []
    triples.each_with_index do |n, i|
      array = to_alphabetic_array_less_than_1000 n, ret.empty?
      unless array == [:zero]
        array << BIG_FIGURES[i] unless i == 0
        ret.unshift array 
      end
    end
    ret.flatten
  end

  def to_ordinal_array
    alphabetics = to_alphabetic_array
    alphabetics[-1] =
      if special = SPECIAL_ORDINALS[LESS_THAN_20.index(alphabetics.last) || 0]
        special
      elsif special = SPECIAL_ORDINALS[(DOUBLE_FIGURES.index(alphabetics.last) || 0) * 10]
        special
      else
        :"#{alphabetics.last}th"
      end
    alphabetics
  end

  def to_alphabetic_array_less_than_1000(num, last=false)
    case num
    when 0..19
      [LESS_THAN_20[num]]
    when 20..99
      single = to_alphabetic_array_less_than_1000(num % 10)
      if single == [:zero]
        [DOUBLE_FIGURES[num / 10]]
      else
        [DOUBLE_FIGURES[num / 10], *single]
      end
    else
      double = to_alphabetic_array_less_than_1000(num % 100)
      if not last
        [LESS_THAN_20[num / 100], HUNDRED, *double]
      elsif double == [:zero]
        [LESS_THAN_20[num / 100], HUNDRED]
      else
        [LESS_THAN_20[num / 100], HUNDRED, AND, *double]
      end
    end
  end
end

class Array
  def method_missing(symbol, *args, &block)
     name = symbol.to_s
    if name[-1] == ?=
      index = Integer.from_ordinal(name[0...-1], '_') - 1
      self[index] = args.first
    else
      index = Integer.from_ordinal(name, '_') - 1
      self[index]
    end
  rescue
    super
  end
end
