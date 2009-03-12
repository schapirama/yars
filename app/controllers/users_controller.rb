class UsersController < ApplicationController
  DEFAULT_ROLE = 'user'
  before_filter :login_required, :only => "change_password"
  ssl_required :new, :create, :change_password, :amnesia
  
  # render new.rhtml
  def new
    @user = User.new
  end
 
  def create
    logout_keeping_session!
    @user = User.new(params[:user])
    success = @user && @user.save
    if success && @user.errors.empty?
      # Protects against session fixation attacks, causes request forgery
      # protection if visitor resubmits an earlier form using back
      # button. Uncomment if you understand the tradeoffs.
      # reset session
      
      # Assign this user to the default role
      role = Role.find_by_name(UsersController::DEFAULT_ROLE).users << @user

      self.current_user = @user # !! now logged in
      redirect_back_or_default('/')
      flash[:notice] = "Thanks for signing up! "
    else
      render :action => 'new'
    end
  end
  
  def change_password 
    @user = current_user
    if request.post?
      if @user.authenticated?(params[:curr_password])
        flash[:notice] = "We have updated your password. Thanks." and redirect_to root_url if @user.update_attributes(params[:user])
      else
        flash[:error] = "The current password that you typed doesn't match our records. Please, try again."
      end
    end
  end
  
  ###
  # User forgot password. Asks for a new password, stores it in an extra field in the User table.
  # Sends confirmation via email. When user clicks on link (see confirm_password_change), 
  #   it takes the changed_crypted_pwd and makes it the real pwd.
  ###
  def amnesia
    if request.post?
      @user = User.find_by_email(params[:email])
      if @user
        @user.sending_reminder = true
        if @user.update_attributes(params[:user])
          Bj.submit "./script/runner ./jobs/email_changed_pwd.rb #{params[:email]} #{@user.id}ff#{@user.crypted_changed_password}"
          flash[:notice] = "We have recorded your new password and sent you an email confirmation. Please, click on the link provided and then try to login again."
          redirect_to login_url
        else
        end
      else
        flash[:error] = "We couldn't find that account, sorry. Please try again"
      end
    end
  end
  
  ###
  # Confirm the new password
  ###
  def confirm_password_change
    id, pwd = params[:id].scan(/^(\d+)ff(.*)/).flatten
    logger.warn("Id: #{id}, #{pwd}")
    user = User.find(id)
    if user and user.crypted_changed_password == pwd
      user.crypted_password = user.crypted_changed_password
      user.crypted_changed_password = nil
      user.save
    end
    flash[:notice] = "We have confirmed the change of your password. Please, log in now."
    redirect_to login_url
  end
  
end
