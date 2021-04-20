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
          end
    end
  end