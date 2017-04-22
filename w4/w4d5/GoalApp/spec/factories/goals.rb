# == Schema Information
#
# Table name: goals
#
#  id          :integer          not null, primary key
#  name        :string           not null
#  description :text             not null
#  user_id     :integer          not null
#  public      :string           default("public"), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  fulfilled   :string           default("no"), not null
#

FactoryGirl.define do
  factory :goal do
    
  end
end
