class ImageController < ApplicationController
  def index
    @images = Image.all()
  end

  def show
  end

  def create
  end

  def destroy
  end

end
