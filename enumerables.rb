module Enumerable
  def my_each
    return self.dup unless block_given?

      arr = []
      each do |item|
      arr.push(yield(item))
      end
      arr
    end
  end

  def my_each_with_index
    return self.dup unless block_given?

      arr = []
      each do |i|
      arr.push(yield([i], i))
      end
      arr
    end
  end
  end

  def my_select
    return self.dup unless block_given?
    arr = []
    my_each do |x|
    arr.push(x) if yield(x)
    end
    arr
  end
end

end  
