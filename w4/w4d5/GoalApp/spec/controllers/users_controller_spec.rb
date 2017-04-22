require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "GET #new" do
    it "renders signup page" do
      get :new

      expect(response).to render_template("new")
      expect(response).to have_http_status(200)
    end
  end

  describe "POST #create" do
    it "saves new user to database" do
      post :create, user: {username: "somebody", password: "password"}

      expect(User.last.username).to eq("somebody")
    end

    it "validates presence of username and password" do
      post :create, user: {username: "", password: ""}

      expect(response).to render_template("new")
      expect(flash[:errors]).to be_present
    end

    it "validates minimum length of password" do
      post :create, user: {username: "Hank", password: "short"}

      expect(response).to render_template("new")
      expect(flash[:errors]).to be_present
    end

    it "redirects upon successful signup" do
      post :create, user: {username: "Hank", password: "password"}

      expect(response).to redirect_to(user_url(current_user.id))
    end

    it "signs new user in" do
      post :create, user: {username: "Hank", password: "password"}

      expect(current_user.username).to be("Hank")
    end
  end

  describe "GET #show" do
    it "displays the user" do
      user = User.create(username: "Hank", password: "password")
      get :show, id: user.id

      expect(response).to render_template('show')
    end

    it "sends error message if user not found" do
      begin
        get :show, id: -1
      rescue
        ActiveRecord::RecordNotFound
      end
      expect(response).not_to render_template("show")
    end
  end
end
