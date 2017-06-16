class SessionController < ApplicationController

  def authentication
    @user = User.find_by_email(params[:email])
    puts params[:email]
    puts @user.inspect
    puts params[:password]
    if @user &&  @user.authenticate(params[:password]) && @user.active
      puts @user.active
      session[:user_id] = @user.id
      redirect_to :back, :flash => {:success => "Logged In Successfully"}
      puts "1111111111111111111111111111111111111"
      puts session[:user_id]
    else
      redirect_to root_url, :flash => {:error => "Wrong creds. Try again"}
      puts "2222222222222222222222222222222222222222"
      session[:user_id] = nil
    end
  end

  def sign_up
    @user = User.create(first_name: params[:first_name], last_name: params[:last_name], email: params[:email], active: 'false')
    @user.password_digest = BCrypt::Password.create(params[:password])
    @user.activation_code = SecureRandom.urlsafe_base64
    if @user.save
      redirect_to root_url, :flash => {:success => "Please check your email for verification"}
      UserMailer.user_activation(@user).deliver_now
    else
      redirect_to root_url, :flash => {:error => "Try again"}
    end
  end

  def activate_user
    @codes = params[:activation_code]
    @user = User.find_by_activation_code(params[:activation_code])
    if @user
      puts @user.inspect
      @user.active = 'true'
      @user.save
      redirect_to root_url, :flash => {:success => "Thank you for verifying your email. Please sign in to continue"}
      WelcomeEmailMailer.welcomeemail(@user).deliver_now
    else
      @user.active = 'false'
      redirect_to :back, :flash => {:error => 'Cannot activate user'}
    end
  end

  def reset
    @user = User.find_by_email(params[:email])
    if @user.present? && @user.active
      ForgetPassMailer.password_reset(@user).deliver_now
      redirect_to root_url, :flash => {:notice => 'Please check your email'}
      puts 'user'
    else
      redirect_to root_url, :flash =>{:notice => 'User does not exixts'}
      puts "not a user"
    end

  end

  def reset_password
    @codes = params[:activation_code]
    @user = User.find_by_activation_code(params[:activation_code])
    if @user.activation_code == @codes

      # @dialog = true

    else
      redirect_to root_url, :flash => {:error => 'try again'}
    end
  end

  def logout
    @user = User.find(session[:user_id])
    puts "888888888888888888888888"
    puts session[:user_id]
    # session[:user_id] = nil
    # session.delete(:user_id)
    reset_session
    redirect_to root_url, :flash=> {:error => "You have been successfully logged out!"}
  end

  def change_pass
    @current_user = User.find_by_activation_code(params[:activation_code])
    @user = User.find_by_activation_code(params[:activation_code])

    if @user.update(:first_name => params[:first_name], :last_name => params[:last_name],:email => params[:email] ,:phone => params[:phone])
      puts "5555555555555555555555555"
      puts params[:password]
      @user.password_digest = BCrypt::Password.create(params[:password])
      @user.save
      redirect_to root_url, :flash => {:notice => "Password updated"}
      # reset_session
    else
      redirect_to :back, :flash => {:error => "Password not changed"}
    end
  end


  # def authf
  #   @user = User.find_by_email(params[:email])
  #   data={}
  #   if @user.present?
  #       data['response']=true
  #   else
  #       data['response']=false
  #   end
  #
  #   respond_to do |format|
  #                   format.json { render json: data }
  #             end
  #
  # end


  def update_profile
    @user = User.find(session[:user_id])
    @country = Country.all

    @current_user = User.find(session["user_id"])
    # @cart = ShoppingCart.where(:user_id => session[:user_id])
    @cart_count = Cart.where(:user_id => session[:user_id]).count
  end

  def change_info
    @user = User.find(session[:user_id])
    # @user.email = params[:email]
    # if @user.email_changed?
    #   av = @user.email = params[:email]
    #   UserMailer.user_activation(@user).deliver_now
    # else
    #   av = @user.email_was
    # end
    if @user.update(:first_name => params[:first_name], :last_name => params[:last_name],:email => params[:email] ,:phone => params[:phone], :address => params[:address], :city => params[:city], :state => params[:state], :post_code => params[:post_code], :country => params[:country], :middle_name => params[:middle_name] )
      @user.save
      redirect_to '/event/index/', :flash => {:success => "Profile updated"}
      # reset_session
    else
      redirect_to :back, :flash => {:error => "Profile cannot be updated"}
    end
  end


  # def update_pass
  #   @user = User.find_by_activation_code(params[:activation_code])
  #   @current_user = User.find_by_activation_code(params[:activation_code])
  #   if @user.update(:first_name => params[:first_name], :last_name => params[:last_name],:email => params[:email] ,:phone => params[:phone])
  #     @user.password = BCrypt::Password.create(params[:password])
  #     @user.save
  #     redirect_to root_url, :notice => "password updated"
  #     # reset_session
  #   else
  #     redirect_to :back, :notice => "cannot change info"
  #   end
  # end


  def findemail

    begin
    #  response.headers['X-CSRF-Token'] = form_authenticity_token
     User.find_by_email(params[:email]).id
     render :json => false
   rescue Exception => e
     render :json => true
   end
      # @user = User.find_by_email(params[:email])
      # puts params([:email])
      # respond_to do |format|
      #   format.json {render :json => {email_exists: @user.present?}}
  end


  def reset_user
    begin
    #  response.headers['X-CSRF-Token'] = form_authenticity_token
     User.find_by_email(params[:email]).id
     puts "55555555555555555555555555555555555555555555"
     puts params[:email]
     render :json => true
    rescue Exception => e
     render :json => false
    end

  end

end
