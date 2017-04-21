# == Schema Information
#
# Table name: tracks
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  album_id   :integer          not null
#  category   :string           default("regular"), not null
#  lyrics     :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Track < ApplicationRecord
  validates :name, :album_id, :category, presence: true

  belongs_to :album,
  foreign_key: :album_id,
  primary_key: :id,
  class_name: "Album"

  has_one :band,
  through: :album,
  source: :band

  has_many :notes,
    primary_key: :id,
    foreign_key: :track_id,
    class_name: :Note
end
