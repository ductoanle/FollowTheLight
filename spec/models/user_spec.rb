require 'spec_helper'

describe User do
  before(:each) do
    @attr = {:name => "An example user", :email => "ethan.le@ufintiy.com"}
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

end
