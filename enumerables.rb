module Enumerable
  def my_each
    i = 0
    return to_enum unless block_given?
    while i < length
      yield self[i]
      i += 1
    end
  end

  #[1, 2, 3, 4, 5].my_each { |i| puts i**2 }

  def my_each_with_index
    i = 0
    return to_enum unless block_given?
    while i < length
      yield(self[i], i)
      i += 1
    end
  end

  #[1, 2, 3, 4, 5].my_each_with_index { |i, index| puts i.to_s + " index:" + index.to_s }

  def my_select
    return to_enum unless block_given?

    arr = []
    my_each do |i| 
      arr << i if yield i 
    end
    arr
  end

  #puts [1, 2, 3, 4, 5].my_select { |i| i.even? }

  def my_all?
    my_each do |i|
      return false unless yield(i)
    end
    true
  end

  puts [1, 2, 3, 4, 5].all? { |i| i <= 5 }
  
  def my_any?
    my_each do |i|
      return true if yield(i)
    end
    false
  end

  puts [1, 2, 3, 4, 5].any? { |i| i < 2 }

  def my_none?
    my_each do |i|
      return false if yield(i)
    end
    true
  end

  # [1, 2, 3, 4, 5].my_none? { |i| puts i < 10 }

  def my_count
    count = 0
    my_each do |i|
      count += 1 if yield(i)
    end
    count
  end

  # puts [1, 2, 3, 4, 5].my_count { |i| i % 2 == 0 }

  #
  # (original map method)
  #
  # def my_map
  #   result =[]
  #
  #   if self.my_each { |i| result << yield(i)}
  #     return result
  #   else
  #     return self
  #   end
  #
  # end
  # [1, 2, 3, 4, 5].my_map { |i| puts i**2 }
  #
  # def my_map(&proc)(proc map method)
  #   result = []
  #   self.my_each { |i| results << proc.call(i)}
  #     return result
  # end
  #
  # proc = Proc.new { |i| i**2 }
  # puts [1, 2, 3].my_map(proc)
  #

  def my_map(proc = nil)
    result = []
    my_each { |i| results << proc.call(yield(i)) }
    result
  end

  def my_inject
    result = self[0]
    self[1..-1].my_each do |element|
      result = yield(result, element)
    end
    result
  end
end

def multiply_els(elements)
  elements.my_inject { |product, n| product * n }
end

# puts multiply_els([1, 2, 3])
