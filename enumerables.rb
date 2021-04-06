# rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
module Enumerable
  def my_each
    return to_enum unless block_given?

    i = 0 # iterator
    while i < to_a.length
      yield to_a[i]
      i += 1
    end
    self
  end

  def my_each_with_index
    return to_enum unless block_given?

    i = 0
    while i < to_a.length
      yield to_a[i], i
      i += 1
    end
    self
  end


  def my_select
    return to_enum unless block_given?

    arr = []
    my_each do |i|
      arr << i if yield i
    end
    arr
  end

  def my_all?(para = nil)
    if block_given?
      my_each { |element| return false unless yield element }
    elsif para
      my_each { |element| return false unless match?(element, para) }
    else
      my_each { |element| return false unless element }
    end
    true
  end

  def my_any?(para = nil)
    if block_given?
      my_each { |element| return true if yield element }
    elsif para
      my_each { |element| return true if match?(element, para) }
    else
      my_each { |element| return true if element }
    end
    false
  end

  def my_none?(para = nil)
    if block_given?
      my_each { |element| return false if yield element }
    elsif para
      my_each { |element| return false if match?(element, para) }
    else
      my_each { |element| return false if element }
    end
    true
  end

  def my_count(*args)
    count = 0

    if block_given?
      my_each { |i| count += 1 if yield i }
    elsif args[0]
      my_each { |i| count += 1 if i == args[0] }
    else
      my_each { |i| count += 1 }
    end

    count
  end

  def my_map(proc = nil)
    result = []
    if proc
      my_each { |i| result << proc.call(yield(i)) }
    elsif block_given?
      my_each { |i| result << yield(i) }
    else
      return to_enum unless block_given?
    end
    result
  end

  def my_inject(total = nil, symb = nil)
    if (total.is_a?(Symbol) || total.is_a?(String)) && symb.nil?
      symb = total
      total = nil
    end
    if !block_given? && !symb.nil?
      my_each { |i| total = total.nil? ? i : total.send(symb, i) }
    else
      my_each { |i| total = total.nil? ? i : yield(total, i) }
    end
    total
  end

  def match?(element, para)
    case para
    when Regexp
      element =~ para
    when Class
      element.is_a?(para)
    else
      element == para
    end
  end
end

# rubocop:enable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity

def multiply_els(elements)
  elements.my_inject { |product, i| product * i }
end
