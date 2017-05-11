json.extract! @pokemon, :id, :name, :attack, :defense, :poke_type, :moves

json.image_url asset_path(@pokemon.image_url)

json.items @pokemon.items do |item|
  json.extract! item, :id, :name, :pokemon_id, :price, :happiness
  json.image_url asset_path(item.image_url)
end
