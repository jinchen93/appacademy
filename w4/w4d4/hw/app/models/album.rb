# == Schema Information
#
# Table name: albums
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  band_id    :integer          not null
#  category   :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Album < ApplicationRecord
  validates :name, :band_id, :category, presence: true

  belongs_to :band,
  foreign_key: :band_id,
  primary_key: :id,
  class_name: "Band"

  has_many :tracks,
  dependent: :destroy,
  foreign_key: :album_id,
  primary_key: :id,
  class_name: "Track"

end
