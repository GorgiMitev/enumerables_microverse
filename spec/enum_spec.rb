require_relative '../enumerables'

describe Enumerable do
  describe '#my_each' do
    it 'Returns an enumerable when no block is given' do
      expect([1, 3, 5].my_each).to be_a(Enumerable)
    end
    context 'when block is given' do
      it 'Returns the range of numbers passed when range is given' do
        expect((1..5).my_each { |i| i }).to eql(1..5)
      end
      it 'Returns the new array with the block given' do
        expect([1, 2, 3].my_each { |i| i * 2 }) == [2, 4, 6]
      end
      it 'Returns a key and a value' do
        expect({ goat: 'bleat', snake: 'hiss' }.my_each { |i| i }).to eql(goat: 'bleat', snake: 'hiss')
      end
    end
  end

  describe '#my_each_with_index' do
    it 'Returns an enumerable when no block is given' do
      expect([1, 3, 5].my_each_with_index).to be_a(Enumerable)
    end
    context 'when block is given' do
      it 'Returnes the values with their idices' do
        expect([1, 3, 5].my_each_with_index { |el, idx| puts "#{el} #{idx}" }).to eql([1, 3, 5])
      end
    end
  end
  describe '#my_select' do
    it 'Returns an enumerable when no block is given' do
      expect([1, 3, 5].my_select).to be_a(Enumerable)
    end
    context 'when block is given' do
      it 'Returns the range of numbers passed when range is given' do
        expect((1..5).my_select { |i| i > 2 }).to eql([3, 4, 5])
      end
      it 'Returns the even numbers passed when range is given' do
        expect((1..10).my_select(&:even?)).to eql([2, 4, 6, 8, 10])
      end
      it 'Returns the range of numbers passed when range is given' do
        expect({ goat: 10, snake: 20, dog: 15 }.my_select { |_k, v| v > 10 }).to eql [[:snake, 20], [:dog, 15]]
      end
    end
  end

  describe '#my_all?' do
    it 'Returns true if self is empty' do
      expect([].my_all?).to eql(true)
    end
    it 'Returns false if self is not empty' do
      expect([nil].my_all?).to eql(false)
    end
    it 'Returns true if the values in the array are even' do
      expect([2, 4, 6].my_all?(&:even?)).to eql(true)
    end
    it 'Returns true if all of the given strings in the array are same size' do
      expect(%w[bacon mango apple].my_all? { |i| i.size == 5 }).to eql(true)
    end
    it 'Returns true if the all of the given values in the array are bigger than 10' do
      expect((11..35).my_all? { |i| i > 10 }).to eql(true)
    end
    it 'Returs false if none of the hash values is an odd number' do
      expect({ x: 22, y: 4, z: 3 }.my_all? { |_k, v| v.odd? }).to eq(false)
    end
  end
  describe '#my_any?' do
    it 'Returns false if self is empty' do
      expect([].my_any?).to eql(false)
    end
    it 'Returns true if self is not empty' do
      expect([1, 2, 3].my_any?).to eql(true)
    end
    it 'Returns true if any of the values in the array are even' do
      expect([1, 4, 9].my_any?(&:even?)).to eql(true)
    end
    it 'Returns false if none of the values in the array are even' do
      expect([1, 5, 9].my_any?(&:even?)).to eql(false)
    end
    it 'Returns true if any of the given strings in the array is equal to 5 words' do
      expect(%w[strawberry orange apple].my_any? { |i| i.size == 5 }).to eql(true)
    end
    it 'Returns true if the any of the given values in the array are bigger than 10' do
      expect((2..12).my_any? { |i| i > 10 }).to eql(true)
    end
    it 'Returs false if none of the hash values is an odd number' do
      expect({ x: 22, y: 4, z: 8 }.my_any? { |_k, v| v.odd? }).to eq(false)
    end
  end
  describe '#my_none' do
    it 'Returns true if self is empty' do
      expect([].my_none?).to eql(true)
    end
    it 'Returns false if self is not empty' do
      expect([1, 2, 3].my_none?).to eql(false)
    end
    it 'Returns true if none of the values in the array are even' do
      expect([1, 5, 9].my_none?(&:even?)).to eql(true)
    end
    it 'Returns true if none of the given strings in the array is equal to 5 words' do
      expect(%w[strawberry orange banana].my_none? { |i| i.size == 5 }).to eql(true)
    end
    it 'Returns false if  none of the given values in the array are bigger than 10' do
      expect((12..30).my_none? { |i| i > 10 }).to eql(false)
    end
    it 'Returns true if none of the hash values is an odd number' do
      expect({ x: 22, y: 4, z: 8 }.my_none? { |_k, v| v.odd? }).to eq(true)
    end
    it 'returns true if none of the elements is lesser than 3 chracters ' do
      expect(%w[mickey mouse].my_none? { |i| i.length < 3 }).to be(true)
    end
  end
  describe '#my_count' do
    it 'counts the number of the elements in the array ' do
      expect([1, 2, 3].my_count).to be(3)
    end
    it 'counts the even numbers passed when range is given' do
      expect((1..10).my_count(&:even?)).to be(5)
    end
    it 'counts the number of elements bigger than 3 when range is given' do
      expect((1..10).my_count { |i| i > 3 }).to be(7)
    end
    it 'counts the number of words in the given array' do
      expect(%w[we are going on vacation].my_count { |word| word.count(word) }).to be(5)
    end
    it 'counts the number of words has the "e" character ' do
      expect(%w[vacation is short].my_count(/e/)).to be(0)
    end
    it 'counts the number of times the number three appears in the array ' do
      expect([1, 2, 2, 4, 3, 3].my_count(3)).to be(2)
    end
    it 'counts the number of hash values that are odd number' do
      expect({ a: 1, b: 2, c: 3, d: 4 }.my_count { |_k, v| v.odd? }).to eq(2)
    end
  end
  describe '#my_map' do
    it 'Returns an enumerable when no block is given' do
      expect([1, 3, 5].my_map).to be_a(Enumerable)
    end
    context 'when block is given' do
      it 'Returns a uppercase array' do
        expect(%w[vacation].my_map(&:upcase)).to eql(%w[VACATION])
      end
      it 'Returns a new array of the elements multiplied by 2' do
        expect([1, 2, 3].my_map { |i| i * 2 }).to eql([2, 4, 6])
      end
      it 'returns a new array with all elements converted to integrs' do
        expect(%w[1 2 3 4 5].my_map(&:to_i)).to eql([1, 2, 3, 4, 5])
      end
      it 'returns the class of each element in the given array' do
        expect(['boy', :girl, 2.4].my_map(&:class)).to eql([String, Symbol, Float])
      end
    end
    describe '#my_inject' do
      it 'Returns the addition of the values in the array' do
        expect([3, 6, 10, 13].inject(:+)).to eql(32)
      end
      it 'Returns the multiplication of the values in the array' do
        expect([3, 5, 10].inject(:*)).to eql(150)
      end
      it 'Returns the multiplication of the values in the array' do
        expect([3, 5, 10].inject(:-)).to eql(-12)
      end
      it 'Returns the multiplication of the values in the array' do
        expect([16, 4, 4].inject(:/)).to eql(1)
      end
      it 'Returns the longest word in a given block' do
        expect(%w[welcome to spain].my_inject { |a, word| a.length > word.length ? a : word }).to eql('welcome')
      end
    end
  end
end
