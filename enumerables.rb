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
    i = 0
    while i < self.length
      if !yield(self[i])
        return false 
      end
        return true 
    end
  end
#[1, 2, 3, 4, 5].all? { |i| puts i < 5 }



  def my_any?
    i = 0
    while i < self.length
      if !yield(self[i])
        return false 
      end
        return true 
    end
  end

#[1, 2, 3, 4, 5].any? { |i| puts i < 6 }

def my_none?
  i = 0
  while i < self.length
    if yield(self[i])
      return true 
    end
      return false 
  end
end
#[1, 2, 3, 4, 5].my_none? { |i| puts i < 10 }

end  
