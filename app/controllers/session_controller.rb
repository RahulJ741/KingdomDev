class SessionController < ApplicationController

  def authentication
    @user = User.find_by_email(params[:email])
    if @user && @user.authenticate(params[:password]) && @user.active == 'true'
      session[:user_id] = @user.id
      redirect_to root_url, :notice => "Login Successfull"
      puts "1111111111111111111111111111111111111"
    else
      redirect_to root_url, :notice => "wrong Creds. Try again"
      puts "2222222222222222222222222222222222222222"
    end
  end

  def sign_up
    @user = User.create(first_name: params[:first_name], last_name: params[:last_name], email: params[:email], active: 'false')
    @user.password = BCrypt::Password.create(params[:password])
    @user.activation_code = SecureRandom.urlsafe_base64
    if @user.save
      redirect_to root_url, :notice => "User created"
      UserMailer.user_activation(@user).deliver_now
    else
      redirect_to root_url, :notice => "Try again"
    end
  end

  def activate_user
    @codes = params[:activation_code]
    @user = User.find_by_activation_code(params[:activation_code])
    if @user.activation_code == @codes
      @user.active = 'true'
      redirect_to root_url
    else
      @user.active = 'false'
      redirect_to :back, :notice => 'cannot activate_user'
    end
  end

  def reset
    @user = User.find_by_email(params[:email])
    if @user.present?
      ForgetPassMailer.password_reset(@user).deliver_now
      redirect_to root_url, :notice => 'please check your email'
      puts 'user'
    else
      redirect_to root_url, :notice => 'user does not exixts'
      puts "not a user"
    end

  end

  def reset_password
    @codes = params[:activation_code]
    @user = User.find_by_email
    if @user.activation_code == @codes
      redirect_to "/change_pass"
    else
      redirect_to root_url, :notice => 'try again'
    end
  end

  def logout
    reset_session
    @user = nil
  end

  def change_pass

  end
end
