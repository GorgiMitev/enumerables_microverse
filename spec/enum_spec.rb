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
        expect([1, 3, 5].my_each_with_index { |el, idx| puts "#{el} #{idx}" }) === [1, 3, 5]
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
    it 'Returns true if the all of the given strings in the array are same size' do
      expect(%w[bacon mango apple].my_all? { |i| i.size == 5 }).to eql(true)
    end
    it 'Returns true if the all of the given values in the array are bigger than 10' do
      expect((11..35).my_all? { |i| i > 10 }).to eql(true)
    end
    it 'Returs false if none of the hash values is an odd number' do
      expect({ x: 22, y: 4, z: 3 }.my_all? { |_k, v| v.odd? }).to eq(false)
    end
  end
end
