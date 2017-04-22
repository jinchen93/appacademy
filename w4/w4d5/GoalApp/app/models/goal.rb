# == Schema Information
#
# Table name: goals
#
#  id          :integer          not null, primary key
#  name        :string           not null
#  description :text             not null
#  user_id     :integer          not null
#  public      :string           default("public"), not null
#  fulfilled   :string           default("no"), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Goal < ActiveRecord::Base
  validates :name, :description, :user_id, :public, :fulfilled, presence: true
  belongs_to :user,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User

  def toggle_privacy
    if self.public == 'public'
      self.public = 'private'
    else
      self.public = 'public'
    end
    self.save!
  end

  def toggle_fulfilled
    if self.fulfilled == 'yes'
      self.fulfilled = 'no'
    else
      self.fulfilled = 'yes'
    end
    self.save!
  end
  
end
