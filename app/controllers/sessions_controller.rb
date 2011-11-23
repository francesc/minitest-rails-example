class SessionsController < ApplicationController
  def create
    if user = User.authenticate(params[:username], params[:password])
      session[:user_id] = user.id
      flash[:notice] = "Welcome #{user.first_name}!"
      redirect_to "/"
    else
      flash[:alert] = "Username and/or password is incorrect."
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "Signed out successfully."
    redirect_to "/"
  end
end
