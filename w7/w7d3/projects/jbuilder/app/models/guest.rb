# == Schema Information
#
# Table name: guests
#
#  id             :integer          not null, primary key
#  name           :string
#  age            :integer
#  favorite_color :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Guest < ActiveRecord::Base
  validates :name, :age, :favorite_color, presence: true
  
  has_many :gifts
  has_many :invitations
  has_many :parties, through: :invitations, source: :party
end
