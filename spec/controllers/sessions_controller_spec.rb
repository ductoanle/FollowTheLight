require 'spec_helper'

describe SessionsController do
  render_views
  describe "Signin page" do
    it "should be successful" do
      get :new
      response.should be_success
    end
    it "should have the correct title" do
      get :new
      response.should have_selector("title", :content=>"Sign in")
    end
  end

  describe "invalid login" do
    before (:each) do
      @attr = {:email => "ethan.le@ufinity.com", :password => "invalid"}
    end

    it "should reject invalid login" do
      post :create, :session => @attr
      response.should render_template(:new)
    end

    it "should have flash.now message" do
      post :create, :session => @attr
      flash.now[:error].should =~ /invalid/i
    end
  end

  describe "success login" do
    before(:each) do
      @user = Factory(:user)
      @attr = {:email=>@user.email, :password=>@user.password}
    end

    it "should allow user to login" do
      post :create, :session=>@attr
      controller.current_user.should ==@user
      controller.should be_signed_in #equiavalent to controller.signed_in?.should be_true
    end

    it "should redirect to the user page" do
      post :create, :session=>@attr
      response.should redirect_to(user_path(@user))
    end
  end

  describe "should reject invalid user sign in" do
    before(:each) do
      @user = Factory(:user)
      @attr={:email => @user.email, :password => "wrong_password"}
    end

    it "should reject user sign in" do
      post :create, :session=>@attr
      response.should render_template("new")
      flash.now[:error] =~ /Invalid email and password/i
    end
  end

  describe "should sign user out" do
    before(:each) do
      @user = Factory(:user)
    end

    it "should sign user out successfully" do
      test_sign_in(@user)
      delete :destroy
      controller.should_not be_signed_in
      response.should redirect_to(root_path)
    end
  end
end
