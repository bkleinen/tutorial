class SessionsController < ApplicationController

  def new
    @title = "Sign in"
  end

 def create
  user = User.authenticate(params[:session][:email],
                           params[:session][:password])
  if user.nil?
    # Create an error message and re-render the signin form.
      flash.now[:error] = "Invalid email/password combination."
      @title = "Sign in"
      render 'new'
   else
    # Sign the user in and redirect to the user's show page.
    sign_in user
    redirect_to user
  end
 end


 def destroy
    sign_out
    redirect_to root_path
  end




   def sign_in(user)
    cookies.permanent.signed[:remember_token] = [user.id, user.salt]
    self.current_user = user
  end

  def sign_out
    cookies.delete(:remember_token)
    self.current_user = nil
  end

  def signed_in?
    !current_user.nil?
  end


  def current_user=(user)
    @current_user = user
  end

  def current_user
     current_user ||= user_from_remember_token
  end


  private

    def user_from_remember_token
      User.authenticate_with_salt(*remember_token)
    end

  def remember_token
      cookies.signed[:remember_token] || [nil, nil]
    end


end
