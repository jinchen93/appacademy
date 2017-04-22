require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  subject(:user) { User.create(username: 'Bobby', password: 'password') }

  describe 'GET #new' do
    it 'should send you to the log in page' do
      get :new
      expect(response).to render_template('new')
    end
  end

  describe 'POST #create' do
    # it 'should take in username and password' do
    #   post :create, user: { username: 'Bobby', password: 'password' }
    #
    #   current_user = User.find_by(session_token: session[:session_token])
    #
    #   expect(current_user.username).to be('Bobby')
    # end

    it 'should reject invalid usernames and passwords' do
      post :create, user: { username: 'Bobby', password: 'pass' }

      expect(response).to render_template('new')
      expect(flash[:errors]).to be_present
    end

    it 'redirects upon successful login' do
      post :create, user: { username: 'Bobby', password: 'password' }

      expect(response).to redirect_to(goals_url)
    end

    # it "sets current session_token to be current_user/'s session token" do
    #   post :create, user: { username: 'Bobby', password: 'password' }
    #
    #   expect(session[:session_token]).to eq(current_user.session_token)
    # end
  end

  describe 'DELETE #destroy' do
    before do
      post :create, user: { username: 'Bobby', password: 'password' }
      session[:session_token] = user.session_token
      user.save!
    end

    # it 'resets session token' do
    #   old_session_token = user.session_token
    #   delete :destroy
    #
    #   expect(session[:session_token]).to be_nil
    #   expect(old_session_token).not_to eq(user.session_token)
    # end

    it 'resets current user' do
      delete :destroy

      expect(@current_user).to be_nil
    end
    #
    # it 'redirects to the user show page' do
    #   delete :destroy
    # 
    #   expect(response).to redirect_to(user_url(user))
    # end
  end
end
