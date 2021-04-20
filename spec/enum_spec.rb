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
end
