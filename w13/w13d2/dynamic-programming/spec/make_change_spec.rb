require 'dynamic_programming'
require 'rspec'
require 'rspec-benchmark'

describe 'Make change' do
  include RSpec::Benchmark::Matchers
  let(:coins) { [2, 5, 7, 10] }
  let(:dp) { DynamicProgramming.new() }

  it 'handles the zero case' do
    expect(dp.make_change(0, coins)).to eq([])
  end

  it 'handles cases with no solution' do
    expect(dp.make_change(1, coins).nil?).to be(true)
    expect(dp.make_change(3, coins).nil?).to be(true)
  end

  it 'handles recursive cases' do
    expect(dp.make_change(12, coins)).to eq([2, 10])
    expect(dp.make_change(54, coins)).to eq([7, 7, 10, 10, 10, 10])
  end

  it 'runs in non-exponential time' do
    expect { dp.make_change(1000, coins) }.to perform_under(100).ms
  end
end
