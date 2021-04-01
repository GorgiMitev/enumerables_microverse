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