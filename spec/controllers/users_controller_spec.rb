require 'spec_helper'

describe UsersController do
  render_views

  describe "GET 'signup'" do
    describe "Render page" do
      it "should be successful" do
        get :new
        response.should be_success
      end
      it "should have proper title" do
        get :new
        response.should have_selector("title", :content=>"Sign Up")
      end
    end
    describe "failed submit new user" do
      before(:each) do
        @attr = {:name => '', :email => '', :password => '', :password_confirmation => ''}
      end

      it 'should not create a user' do
        lambda do
          post :create, :user => @attr
        end.should_not change(User, :count)
      end

      it 'should have the right title' do
        post :create, :user=>@attr
        response.should have_selector("title", :content=>'Sign Up')
      end

      it 'should render the new page ' do
        post :create, :user=>@attr
        response.should render_template('new')
      end
    end

    describe "successful submit a new user" do
      before(:each) do
        @attr = {:name => 'Ethan Le', :email =>'ethan.le@ufinity.com', :password => 'ductoanle',
                :password_confirmation => 'ductoanle'}
      end

      it 'should create a new user' do
        lambda do
          post :create, :user => @attr
        end.should change(User,:count).by(1)
      end

      it 'should redirect to user show page' do
        post :create, :user => @attr
        response.should redirect_to(user_path(assigns(:user)))
      end

      it 'should have a welcome message' do
        post :create, :user=>@attr
        flash[:success].should =~ /Welcome to the sample app/i
      end
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
      assigns(:user).should == @user
    end

    it "should have the username" do
      get :show, :id => @user
      response.should have_selector("h1", :content => @user.name)
    end

    it "should have the gravatar" do
      get :show, :id=>@user
      response.should have_selector("h1>img", :class =>"gravatar")
    end
  end
end
