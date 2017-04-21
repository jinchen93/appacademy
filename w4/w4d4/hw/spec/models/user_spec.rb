require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) do
    User.create(email: 'user@user.com', password: 'password' )
  end

  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password_digest) }
  it { should validate_length_of(:password).is_at_least(6) }

  describe '#is_password?' do
    it 'returns false for invalid passwords' do
      expect(user.is_password?('fake')).to be_falsey
    end

    it 'returns true for valid passwords' do
      expect(user.is_password?('password')).to be_truthy
    end
  end

  describe '#reset_session_token' do
    it 'resets the user session token' do
      old_token = user.session_token
      expect(user.reset_session_token! == old_token).to be_falsey
    end
  end

  describe '::find_by_credentials' do
    before { user.save! }

    it 'returns nil for a non existing user' do
      expect(User.find_by_credentials('faker', 'fakepass')).to be_nil
    end

    it 'returns nil if password is wrong' do
      expect(User.find_by_credentials('user@user.com', 'fake')).to be_nil
    end

    it 'returns nil if user is wrong but password is in the db' do
      expect(User.find_by_credentials('f', 'password')).to be_nil
    end

    it 'returns the user if passed in correct email and password' do
      expect(User.find_by_credentials('user@user.com', 'password')).to eq(user)
    end
  end
end
