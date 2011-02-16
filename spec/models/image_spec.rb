require 'spec_helper'

describe Image do

  context "All field must be present" do
    before(:each) do
      @attr = {:name => 'sunset_at_Hokkaido', :url => "/images/landscape/sunset_1.jpg", :format => "JPG" }
    end

    it "should not accept empty name" do
      @attr = @attr.merge(:name => "")
      image = Image.new(@attr)
      image.should_not be_valid
    end

    it "should not accept empty url" do
      @attr = @attr.merge(:url => "")
      image = Image.new(@attr)
      image.should_not be_valid
    end

    it "should not accept empty type" do
      @attr = @attr.merge(:format => "")
      image = Image.new(@attr)
      image.should_not be_valid
    end
  end

  context "url must be unique" do
    it "should not save 2 images with the same url" do
      image = Factory(:image)
      new_image = Image.new(:name=>image.name, :url=>image.url, :format=>image.format)
      new_image.should_not be_valid
    end
  end

  context "image format must be from a list" do
    it "should not save image with format out of the defined list" do
      image = Factory(:image)
      image.format = "XLS"
      image.should_not be_valid
    end
  end
end
