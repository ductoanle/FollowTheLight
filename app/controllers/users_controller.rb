class UsersController < ApplicationController
  def new
    @user = User.new
    @title = "Sign Up"
  end

  def index
    @users = User.all();
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      #Handle a successful save
      flash[:success] = "Welcome to the Sample Apps!"
      redirect_to @user
    else
      @title = "Sign Up"
      render 'new'
    end
  end

end
