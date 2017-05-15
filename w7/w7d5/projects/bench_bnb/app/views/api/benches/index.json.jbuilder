@benches.each do |bench|
  json.set! bench.id do
    json.id bench.id
    json.description bench.description
    json.lat bench.lat
    json.lng bench.lng
  end
end