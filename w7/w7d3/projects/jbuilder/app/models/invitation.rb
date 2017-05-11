# == Schema Information
#
# Table name: invitations
#
#  id         :integer          not null, primary key
#  guest_id   :integer
#  party_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Invitation < ActiveRecord::Base
  validates :party, :guest, presence: true

  belongs_to :party
  belongs_to :guest
end
