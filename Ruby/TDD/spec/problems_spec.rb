require 'rspec'
require 'problems'

describe Array do
    describe '#uniq' do 
        subject(:arr){[1, 2, 1, 3, 3]}
        it "returns all unique elements in array" do 
            expect(arr.uniq).to match_array([1, 2, 3])
        end

        it "returns unique elements in the order they first appear" do 
            expect(arr.uniq).to eq([1, 2, 3])
        end
    end

    describe '#two_sum' do
        subject(:arr) {[-1, 0, 2, -2, 1]} 
        it "returns array of pairs" do 
            pairs = arr.two_sum
            pairs.each do |ele|
                expect(ele).to be_an_instance_of(Array)
            end 
        end

        it "returns pairs of positions where the elements at those positions sum to zero" do 
            pairs = arr.two_sum
            pairs.each do |i, j|
                expect(arr[i] + arr[j]).to eq(0)
            end      
        end

        it "the array of pairs is sorted dictionary-wise" do 
            expect(arr.two_sum).to eq([[0, 4], [2, 3]])
        end
    end

end

describe 'my_transpose' do 
    subject(:arr) {[
        [0, 1, 2],
        [3, 4, 5],
        [6, 7, 8]
      ]}
    
    it "returns array of same dimensions" do
        trn = my_transpose (arr)
        expect(trn.count).to be(3) 
        trn.each {|col| expect(col.count).to be (3)}
    end

    it "returns the transpose of the array" do 
        expect(my_transpose(arr)).to eq([[0, 3, 6],
        [1, 4, 7],
        [2, 5, 8]])
    end
end

describe 'stock_prices' do 
    subject(:prices) {[2 ,3 ,5, 2, 1 ,8]}
    it "returns a pair of indices" do
        expect(stock_prices(prices).count).to eq(2) 
    end

    it "first day index is less than second" do 
        days = stock_prices(prices)
        expect(days.first).to be <= days.last
    end

    it "outputs the most profitable pair of days" do 
        expect(stock_prices(prices)).to eq([4, 5])
    end
end

#focussing only on move, won?

describe 'Hanoi' do 
    subject(:hanoi){Hanoi.new}

    describe '#move' do 
        it "does not allow moving from an empty tower" do 
            expect{ hanoi.move(1, 2)}.to raise_error("tower 1 is empty")
        end

        it "does not allow moving to a smaller tower" do 
            hanoi.move(0, 1)
            expect{ hanoi.move(0, 1)}.to raise_error("can not move to a smaller tower")
        end

        it "moves a disc from a selected pile to another" do
            hanoi.move(0, 1) 
            expect(hanoi.piles[1].count).to eq(1)
            expect(hanoi.piles[0].count).to eq(2)
            expect(hanoi.piles[2].count).to eq(0)
        end
        it "moves disc at top from selected pile to the top of the other one" do
            top_disc = hanoi.piles[0].first
            hanoi.move(0, 1) 
            expect(hanoi.piles[1].first).to eq(top_disc)
        end
    end

    describe 'won?' do 
        context "returns true if game is won" do 
            it "returns true if all discs are moved to tower 2" do 
                hanoi.move(0, 2)
                hanoi.move(0, 1)
                hanoi.move(2, 1)
                hanoi.move(0, 2)
                hanoi.move(1, 0)
                hanoi.move(1, 2)
                hanoi.move(0, 2)
                expect(hanoi.won?).to eq(true)
            end

            it "returns true if all discs are moved to tower 1" do 
                hanoi.move(0, 1)
                hanoi.move(0, 2)
                hanoi.move(1, 2)
                hanoi.move(0, 1)
                hanoi.move(2, 0)
                hanoi.move(2, 1)
                hanoi.move(0, 1)
                expect(hanoi.won?).to eq(true)
            end
        end

        it "game is not won at first" do 
            expect(Hanoi.new.won?).to eq(false) 
        end
    end
end