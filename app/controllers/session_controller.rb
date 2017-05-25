class SessionController < ApplicationController

  def authentication
    @user = User.find_by_email(params[:email])

    puts params[:email]
    puts @user.inspect
    puts params[:password]
    puts @user.active
    puts @user.authenticate(params[:password])
    if @user &&  @user.authenticate(params[:password]) && @user.active
      session[:user_id] = @user.id
      redirect_to root_url, :notice => "Login Successfull"
      puts "1111111111111111111111111111111111111"
      puts session[:user_id]
    else
      redirect_to root_url, :notice => "wrong Creds. Try again"
      puts "2222222222222222222222222222222222222222"
    end
  end

  def sign_up
    @user = User.create(first_name: params[:first_name], last_name: params[:last_name], email: params[:email], active: 'false')
    @user.password_digest = BCrypt::Password.create(params[:password])
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
    if @user
      puts @user.inspect
      @user.active = 'true'
      @user.save
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
    session[:user_id] = nil
    redirect_to root_url
  end

  def change_pass

  end


  def authf
    @user = User.find_by_email(params[:email])
    data={}
    if @user.present?
        data['response']=true
    else
        data['response']=false
    end

    respond_to do |format|
                    format.json { render json: data }
              end

  end
end
