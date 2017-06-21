require 'rspec'
require 'dynamic_programming'
require 'rspec-benchmark'

describe 'Frog Hops' do
  include RSpec::Benchmark::Matchers
  let(:dp) { DynamicProgramming.new() }

  it 'handles a base case' do
    expect(dp.frog_hops(1)).to eq([[1]])
    expect(dp.frog_hops(2).sort).to eq([[1, 1], [2]])
  end

  it 'handles recursive cases' do
    expect(dp.frog_hops(4).sort).to eq([[1, 1, 1, 1], [1, 1, 2], [1, 2, 1], [2, 1, 1], [2, 2], [1, 3], [3, 1]].sort)
    expect(dp.frog_hops(10).length).to eq(274)
    expect(dp.frog_hops(10)).to include([1, 3, 3, 3])
  end

  it 'runs in non-exponential time' do
    expect { dp.frog_hops(1000) }.to perform_under(100).ms
  end
end
