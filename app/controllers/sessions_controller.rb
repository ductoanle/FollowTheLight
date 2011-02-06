class SessionsController < ApplicationController
  def new
    @title = 'Sign in'
  end

  def destroy
    sign_out
    redirect_to root_path
  end

  def create
    email = params[:session][:email]
    password = params[:session][:password]
    user = User.authenticate(email, password)
    if user.nil?
      @title = 'Sign in'
      flash.now[:error] = "Invalid email and password combination"
      render :new
    else
      sign_in user
      redirect_to user
    end
  end
end
