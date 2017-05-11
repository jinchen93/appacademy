# == Schema Information
#
# Table name: gifts
#
#  id          :integer          not null, primary key
#  title       :string
#  description :string
#  guest_id    :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Gift < ActiveRecord::Base
  validates :description, :title, :guest, presence: true

  belongs_to :guest
end
