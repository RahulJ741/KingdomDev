class SessionController < ApplicationController

  def authentication
    @user = User.find_by_email(params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to '/home', :notice => "Login Successfull"
    else
      redirect_to root_url, :notice => "wrong Creds. Try again"
    end
  end

  def sign_up
    @user = User.create(username: params[:username], password: params[:password], email: params[:email], first_name: params[:first_name], last_name: params[:last_name], phone: params[:phone] )
    if @user.save
      redirect_to root_url, :notice => "User created"
    else
      redirect_to root_url, :notice => "Try again"
    end

  end


end
