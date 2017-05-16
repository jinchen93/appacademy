# == Schema Information
#
# Table name: benches
#
#  id          :integer          not null, primary key
#  description :string           not null
#  lat         :float            not null
#  lng         :float            not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  seating     :integer          not null
#

class Bench < ApplicationRecord
  def self.in_bounds(bounds)
    benches = Bench
      .where(lat: ((bounds['southWest']['lat']).to_f..(bounds['northEast']['lat']).to_f))
      .where(lng: ((bounds['southWest']['lng']).to_f..(bounds['northEast']['lng']).to_f))
  end
end
