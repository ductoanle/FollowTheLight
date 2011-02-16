require 'spec_helper'

describe ImageController do

  describe "GET 'index'" do

    before(:each) do
      @image = Factory(:image)
      Image.create!(:name=>"image_name", :url=>"image_url", :format=>"JPG")
    end
    
    it "should be successful" do
      get 'index'
      response.should be_success
    end

    it "should return all the images" do
      all_images = Image.all()
      assigns(:images).should == all_images 
    end
  end

  describe "GET 'show'" do
    it "should be successful" do
      get 'show'
      response.should be_success
    end
  end

  describe "GET 'create'" do
    it "should be successful" do
      get 'create'
      response.should be_success
    end
  end

  describe "GET 'destroy'" do
    it "should be successful" do
      get 'destroy'
      response.should be_success
    end
  end

end
