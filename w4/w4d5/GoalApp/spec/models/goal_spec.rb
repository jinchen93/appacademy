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

require 'rails_helper'

RSpec.describe Goal, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:public) }
  it { should validate_presence_of(:fulfilled) }
  it { should belong_to(:user) }

  describe '#toggle_privacy' do
    it 'should switch public to private' do
      goal = Goal.create(
        name: 'a',
        description: 'a',
        user_id: 1,
        public: 'public'
      )
      goal.toggle_privacy
      expect(goal.public).to eq('private')
    end

    it 'should switch private to public' do
      goal = Goal.create(
        name: 'a',
        description: 'a',
        user_id: 1,
        public: 'private'
      )
      goal.toggle_privacy
      expect(goal.public).to eq('public')
    end
  end

  describe '#toggle_fulfilled' do
    it 'should switch no to yes' do
      goal = Goal.create(
        name: 'a',
        description: 'a',
        user_id: 1,
        public: 'public',
        fulfilled: 'no'
      )
      goal.toggle_fulfilled
      expect(goal.fulfilled).to eq('yes')
    end

    it 'should switch yes to no' do
      goal = Goal.create(
        name: 'a',
        description: 'a',
        user_id: 1,
        public: 'private',
        fulfilled: 'yes'
      )
      goal.toggle_fulfilled
      expect(goal.fulfilled).to eq('no')
    end
  end
end
