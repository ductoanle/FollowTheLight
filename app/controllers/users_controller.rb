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

  def edit
    @user = User.find(params[:id])
    @title ="Edit User"
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      #Handle a successful save
      flash[:success] = "Welcome to the Sample Apps!"
      sign_in(@user)
      redirect_to @user
    else
      @title = "Sign Up"
      render 'new'
    end
  end

  def update
    @user = User.find(params[:user][:id])
    @user.update_attributes(params[:user])
    p @user
    if @user.save
      p "success"
      #Handle a successful update
      flash[:success] = "User had been updated sucessfully"
      sign_in(@user)
      redirect_to @user
    else
      p "fail"
      p @user.errors
      @title = "Edit User"
      render :action => "edit", :id => @user
    end

  end
end
