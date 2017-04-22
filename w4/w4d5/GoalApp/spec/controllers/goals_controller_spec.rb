require 'rails_helper'

RSpec.describe GoalsController, type: :controller do
  subject(:user) { User.create(username: 'Khan', password: 'password') }

  describe 'GET #new' do
    it 'renders new goal page' do
      get :new, user_id: 1
      expect(response).to render_template("new")
    end
  end

  describe 'POST #create' do
    it 'redirects to user page upon successful creation' do
      post :create, user_id: 1, goal: { name: '' }
      expect(response).to render_template(user_url(id: 1))
    end

    it 'it shames you if you filled out form incorrectly' do
      post :create, user_id: 1
    end
  end

end
