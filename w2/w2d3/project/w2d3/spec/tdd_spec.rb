require 'byebug'
require 'rspec'
require 'tdd'

describe "#my_uniq" do
  let(:orig_array) { [1, 2, 1, 3, 3] }
  let(:my_array) { orig_array.my_uniq }

  it "does not return an array with duplicate values" do
    expect(my_array).to eq([1, 2, 3])
  end

  it "returns a new array" do
    expect(my_array).to be_a(Array)
  end

  it "doesn't exclude values" do
    expect(my_array).to include(1, 2, 3)
  end

  it "doesn't mutate the original array" do
    expect(orig_array).to eq([1, 2, 1, 3, 3])
  end
end

describe "#two_sum" do
  let(:orig_array) { [-1, 0, 2, -2, 1] }
  let(:two_sum_arr) { orig_array.two_sum }

  it "returns a new array" do
    expect(two_sum_arr).to be_a(Array)
  end

  it "doesn't mutate the original array" do
    expect(orig_array).to eq([-1, 0, 2, -2, 1])
  end

  it "doesn't return a single index twice" do
    pass = true
    two_sum_arr.each do |ele|
      pass = false if ele.uniq != ele
    end

    expect(pass).to be_truthy
  end

  it "returns all qualifying pairs of sums" do
    pass = two_sum_arr.include?([0, 4]) && two_sum_arr.include?([2, 3])
    expect(pass).to be_truthy
  end

  it "returns pairs in order" do
    first_idx = two_sum_arr.find_index([0, 4])
    second_idx = two_sum_arr.find_index([2, 3])
    expect(first_idx).to be < second_idx
  end

  it "doesn't return duplicate pairs" do
    sorted_result = two_sum_arr.map(&:sort)
    expect(two_sum_arr).to eq(sorted_result.uniq)
  end

end

describe "#my_transpose" do
  let(:matrix) {[
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8]
  ]}

  let(:transposed) { matrix.my_transpose }

  it "doesn't mutate the original array" do
    expect(matrix).to eq([
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8]
    ])
  end

  it "returns an array" do
    expect(transposed).to be_a Array
  end

  it "transposes rows and columns" do
    expect(transposed).to eq([[0, 3, 6], [1, 4, 7], [2, 5, 8]])
  end

end
