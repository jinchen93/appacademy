require 'rspec'
require 'dynamic_programming'
require 'rspec-benchmark'

describe 'Blair Numbers' do
  include RSpec::Benchmark::Matchers
  let(:dp) { DynamicProgramming.new() }

  it 'handles base cases' do
    expect(dp.blair_nums(1)).to equal(1)
    expect(dp.blair_nums(2)).to equal(2)
  end

  it 'handles recursive cases' do
    expect(dp.blair_nums(6)).to equal(62)
    expect(dp.blair_nums(100)).to eq(3490567772937760827473)
  end

  it 'runs in non-exponential time' do
    expect { dp.blair_nums(1000) }.to perform_under(10).ms
  end
end
