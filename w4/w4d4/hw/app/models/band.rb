# == Schema Information
#
# Table name: bands
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Band < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many :albums,
  dependent: :destroy,
  foreign_key: :band_id,
  primary_key: :id,
  class_name: "Album"

  has_many :tracks,
  through: :albums,
  source: :tracks

end
