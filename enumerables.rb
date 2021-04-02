module Enumerable
  def my_each
    i = 0
    while i < self.length
      yield self[i]
      i += 1
    end
  end

  # [1, 2, 3, 4, 5].my_each { |i| puts i**2 }

  def my_each_with_index
    i = 0
    while i < self.length
      yield(self[i], i)
      i += 1
    end
  end

# [1, 2, 3, 4, 5].my_each_with_index { |i, index| puts i.to_s + " index:" + index.to_s }

  def my_select
    i = 0
    while i < self.length
      yield(self[i])
      i += 1
    end
  end

#[1, 2, 3, 4, 5].my_select { |i| puts i.even? }

def my_all?
  self.my_each { |i|
    unless yield(i)
      return false
    end
    }
    return true
end

#[1, 2, 3, 4, 5].all? { |i| puts i < 5 }

def my_any?
  self.my_each { |i|
    if yield(i)
      return true
    end
  }
  return false
end

#[1, 2, 3, 4, 5].any? { |i| puts i < 6 }

def my_none?
  self.my_each { |i|
    if yield(i)
      return false
    end
  }
  return true
end

#[1, 2, 3, 4, 5].my_none? { |i| puts i < 10 }

def my_count
  count = 0
  self.my_each { |i|
    if yield(i)
      count += 1
    end
  }
  return count
end

#puts [1, 2, 3, 4, 5].my_count { |i| i % 2 == 0 }

=begin

(original map method)

def my_map
  result =[]

  if self.my_each { |i| result << yield(i)}
    return result
  else
    return self
  end

end
[1, 2, 3, 4, 5].my_map { |i| puts i**2 }

def my_map(&proc)(proc map method)
  result = []
  self.my_each { |i| results << proc.call(i)}
    return result
end

proc = Proc.new { |i| i**2 }
puts [1, 2, 3].my_map(proc)

=end

def my_map(proc=nil)
  result = []
  if self.my_each { |i| results << proc.call(yield(i))}
  return result
  else
  return self
end
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
  elements.my_inject {|product, n| product * n }
end

# puts multiply_els([1, 2, 3])