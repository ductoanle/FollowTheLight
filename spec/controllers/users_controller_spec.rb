require 'spec_helper'

describe UsersController do
  render_views

  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end

    it "should have proper title" do
      get 'new'
      response.should have_selector("title", :content=>"Sign Up")
    end
  end

  describe "GET 'show'" do
    before (:each) do
      @user = Factory(:user)
    end

    it "should be successful" do
      get :show, :id => @user
      response.should be_success
    end

    it "should have pull the correct user " do
      get :show, :id => @user
      assign(:user).should == @user
    end

    it "should have the username" do
      get :show, id => @user
      response.should have_selector("h1", :content => @user.name)
    end

    it "should have the gravatar" do
      get :show, :id=>@user
      response.should have_selector("h1>img", :class =>"gravatar")
    end
  end

end
