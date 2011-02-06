require 'spec_helper'

describe "Users" do
  describe "GET /users" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get users_path
      response.status.should be(200)
    end
  end

  describe "Signup new user" do
    describe "failure" do
      it "should not create a new user" do
        lambda do
          visit signup_path
          fill_in "Name", :with =>''
          fill_in "Email", :with => ''
          fill_in "Password", :with => ''
          fill_in "Confirmation", :with => ''
          click_button
          response.should render_template('users/new')
          response.should have_selector("div#error_explanation")
        end.should_not change(User, :count)
      end
    end

    describe 'success' do
      it "should create a new user" do
        lambda do
          visit signup_path
          fill_in "Name", :with => 'Ethan Le'
          fill_in "Email", :with => 'ductoanle@gmail.com'
          fill_in "Password", :with => 'ductoanle'
          fill_in "Confirmation", :with => 'ductoanle'
          click_button
          response.should render_template('users/show')
        end.should change(User, :count).by(1)
      end
    end
  end

  describe "sign in/out" do
    describe "failure" do
      it "should not sign a user in" do
        visit signin_path
        fill_in :email,    :with => ""
        fill_in :password, :with => ""
        click_button
        response.should have_selector("div.flash.error", :content => "Invalid")
      end
    end

    describe "success" do
      it "should sign a user in and out" do
        user = Factory(:user)
        visit signin_path
        fill_in :email,    :with => user.email
        fill_in :password, :with => user.password
        click_button
        p controller.signed_in?
        controller.should be_signed_in
        click_link "Sign out"
        p controller.signed_in?
        controller.should_not be_signed_in
      end
    end
  end
end
