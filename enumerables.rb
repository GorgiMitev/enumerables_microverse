# rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
module Enumerable
  def my_each
    i = 0
    return to_enum unless block_given?
    while i < length
      yield self[i]
      i += 1
    end
  end

  def my_each_with_index
    i = 0
    return to_enum unless block_given?
    while i < length
      yield(self[i], i)
      i += 1
    end
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
      my_each { |i| return false unless yield i }
    elsif para
      my_each { |i| return false unless match?(i, para) }
    else
      my_each { |i| return false unless i }
    end
    true
  end

  def my_any?(para = nil)
    if block_given?
      my_each { |i| return true if yield i }
    elsif para
      my_each { |i| return true if match?(i, para) }
    else
      my_each { |i| return true if i }
    end
    false
  end

  def my_none?(para = nil)
    if block_given?
      my_each { |i| return false if yield i }
    elsif para
      my_each { |i| return false if match?(i, para) }
    else
      my_each { |i| return false if i }
    end
    true
  end

  def my_count
    count = 0
    if block_given?
      my_each do |i|
        count += 1 if yield(i)
      end
    end
    count
  end

  def my_map(proc = nil)
    result = []
    if proc
      my_each { |i| results << proc.call(yield(i)) }
    elsif block_given?
      my_each { |i| new_arr << yield(i) }
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

  def match?(i, para)
    case para
    when Regexp
      i =~ para
    when Class
      i.is_a?(para)
    else
      i == para
    end
  end
end

# rubocop:enable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity

def multiply_els(elements)
  elements.my_inject { |product, i| product * i }
end
