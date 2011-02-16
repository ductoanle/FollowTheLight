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

      it "should sign the user in" do
        post :create, :user=>@attr
        controller.should be_signed_in
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

  describe "edit user" do
    before(:each) do
      @user = Factory(:user)
      test_sign_in(@user)
    end

    it "should be success" do
      get :edit, :id=> @user
      response.should be_success
    end

    it "should have the right title" do
      get :edit, :id=> @user
      response.should have_selector(:title, :content => "Edit User")
    end

    it "should have the username" do
      get :edit, :id=>@user
      response.should have_selector("#user_name", :value=> @user.name)
    end

    context "update user with new email" do
      before(:each) do
        @user.update_attribute(:email,"ethan.le@gmail.com")
        put :update, :id => @user.id, :user => @user
      end

      it "should save the user with new email" do
        User.find(@user.id).email.should == "ethan.le@gmail.com"
      end

      it "should redirect user to user page" do
        response.should redirect_to(user_path(@user))
      end

      it "should display correct flash message" do
        flash[:success] == "User had been updated successfully"
      end

      it "should display error message if fail to update" do
        @user.update_attribute(:email, "ethan.le.gmail.com")
        put :update, :id => @user, :user => @user
        response.should render_template(edit_user_path(@user))
        response.should have_selector("#error_explanation")
      end
    end
  end
end
