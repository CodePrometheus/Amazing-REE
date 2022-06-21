class SessionsController < ApplicationController
  def new
  end

  def create
    if login(params[:email], params[:password])
      flash[:notice] = "login in successfully"
      redirect_to root_path
    else
      flash[:notice] = "email or password is invalid"
      redirect_to new_session_path
    end
  end

  def destroy
    logout
    flash[:notice] = "logout successfully"
    redirect_to root_path
  end
end