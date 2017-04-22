# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { User.create(username: 'pink', password: 'password') }

  it { should validate_presence_of(:username) }
  it { should validate_length_of(:password).is_at_least(6) }
  it { should validate_presence_of(:session_token) }
  it { should validate_presence_of(:password_digest) }
  it { should validate_uniqueness_of(:username) }
  it { should validate_uniqueness_of(:password_digest) }
  it { should validate_uniqueness_of(:session_token) }

  describe '::find_by_credentials' do
    before {user.save!}
    it 'should find correct user' do
      test_user = User.find_by_credentials('pink', 'password')
      expect(test_user).to eq(user)
    end

    it 'should reject wrong info' do
      test_user = User.find_by_credentials('mew2king', 'sucks')
      expect(test_user).not_to eq(user)
    end
  end
end
