class UsersController < ApplicationController
  layout 'layout'

  # render new.rhtml
  def new
    @user = User.new
  end
 
  def create
    logout_keeping_session!
    
    @user       = User.new(params[:user])
    _success    = @user && verify_recaptcha(:model => @user, :message => "Error with captcha !") && @user.save
    
     if _success && @user.errors.empty?
#      self.current_user = @user # !! now logged in
      @user.start_activation_process
      redirect_back_or_default('/')
      flash[:notice] = "Thanks for signing up #{@user.name}! You will receive an e-mail when you godfather will activate your email. Hope it will as soon as possible..."
    else
      flash[:error]  = "We couldn't set up #{@user.name} account, sorry. Please try again, or contact an admin at tracy.loisel@onwlid.com"
      render :action => 'new'
    end
  end
  
  def activate
    @user = User.find_by_activation_code(params[:activation_code])
    if @user
      @user.activate_account
      flash[:notice] = "Superbe ! #{@user.email} is now a fully activated account!"
    else
      flash[:notice] = "The activation code was not found, sorry. Please try again, or contact an admin at tracy.loisel@onwlid.com"
    end
    
    redirect_back_or_default('/')
  end
  
  def reject
    @user = User.find_by_activation_code(params[:activation_code])
    if @user
      @user.reject_account
      flash[:notice] = "OK! #{@user.email} is now rejected."
    else
      flash[:notice] = "The activation code was not found, sorry. Please try again, or contact an admin at tracy.loisel@onwlid.com"      
    end
    
    redirect_back_or_default('/')
  end
  
  def email_activation
    @user = User.find_by_email_activation_code(params[:code])
    if @user then
      @user.confirm_email
      flash[:notice] = "Thank you #{@user.name}! Your email is now confirmed."
    else
      flash[:notice] = "The email activation code was not found, sorry. Please try again, or contact an admin at tracy.loisel@onwlid.com"      
    end
    
    redirect_back_or_default('/')
  end
end
