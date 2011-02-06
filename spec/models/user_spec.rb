require 'spec_helper'

describe User do
  before(:each) do
    @attr = {:name => "An example user",
             :email => "ethan.le@ufintiy.com",
             :password =>"amgenius",
             :password_confirmation => "amgenius"}
  end

  it "should create a new user given the correct valid attributes" do
    User.create!(@attr)
  end

  it "should require a name" do
    no_name_user = User.new (@attr.merge(:name=>""))
    no_name_user.should_not be_valid  
  end

  it "lack of email address should not be valid" do
    no_email_user = User.new(@attr.merge(:email=>""))
    no_email_user.should_not be_valid
  end

  it "should reject name that are too long" do
    long_name = "ductoan " * 5
    long_name_user = User.new(@attr.merge(:name=>long_name))
    long_name_user.should_not be_valid
  end

  it "should reject invalid format email addresses" do
    invalid_email_address = %w[ethan.le.com ethan.le@ufinity ductoanle@gmail,com]
    invalid_email_address.each do |address|
      invalid_email_user = User.new(@attr.merge(:email=>address))
      invalid_email_user.should_not be_valid
    end
  end

  it "should accept valid format email addresses" do
    valid_email_address = %w[ethan.le@ufinity.com ductoanle@gmail.com]
    valid_email_address.each do |address|
      valid_email_user = User.new(@attr.merge(:email=>address))
      valid_email_user.should be_valid
    end
  end

  it "should reject duplicate email address" do
    User.create!(@attr)
    user = User.new(@attr)
    user.should_not be_valid
    upcase_email = @attr[:email].upcase
    user = User.new(@attr.merge(:email=>upcase_email))
    user.should_not be_valid
  end

  describe "password validation" do
    it "should require a password" do
      empty_password = @attr.merge(:password => "", :password_confirmation => "")
      user = User.new(empty_password)
      user.should_not be_valid
    end

    it "password and confirm password must match to create a new user" do
      invalid_confirm_password = @attr.merge(:password_confirmation=>"something wrong")
      user = User.new(invalid_confirm_password)
      user.should_not be_valid
      user = User.new(@attr)
      user.should be_valid
    end

    it "should reject short password" do
      short = "a" * 5
      short_password = @attr.merge(:password => short, :password_confirmation => short)
      user = User.new(short_password)
      user.should_not be_valid
    end

    it "should reject too long password" do
      long = "a" * 51
      long_password = @attr.merge(:password=>long, :password_confirmation=>long)
      user = User.new(long_password)
      user.should_not be_valid
    end
  end

  describe "password encryption" do
    before (:each) do
      @user = User.create!(@attr)
    end

    it "should have password encryption" do
      @user.should respond_to(:encrypted_password)
    end

    it "should not be empty" do
      @user.encrypted_password.should_not be_blank
    end
  end

  describe "password matching" do
    before(:each) do
      @user = User.create!(@attr)
    end
    it "encrypted password must match with submitted password to create user successfully" do
      @user.has_password?(@attr[:password]).should be_true
      @user.has_password?("invalid_password").should be_false
    end
  end

  describe "authenticate users" do
    before(:each) do
      @user = Factory(:user)
    end

    it "authentication should return false for invalid user" do
      invalid_user = @user
      invalid_user.email = "invalid_user@gmail.com"
      User.authenticate(invalid_user.email, invalid_user.password).should be_nil
      invalid_user = @user
      invalid_user.password = "wrong_password"
      User.authenticate(invalid_user.email, invalid_user.password).should be_nil
    end

    it "authentication should return true for valid user" do
      valid_user = @user
      User.authenticate(valid_user.email, valid_user.password).should == @user
    end

    it "authentication with salt should return false for invalid user" do
      invalid_user = @user
      invalid_user.id = "100000000000"
      User.authenticate_with_salt(invalid_user.id, invalid_user.salt).should be_nil
      invalid_user = @user
      invalid_user.salt = "dasdsafdsgdsfgdsfgsdfg"
      User.authenticate_with_salt(invalid_user.id, invalid_user.salt).should be_nil
    end

    it "authentication with salt should return true for valid user" do
      valid_user = @user
      User.authenticate_with_salt(valid_user.id, valid_user.salt).should == @user
    end
  end
end
