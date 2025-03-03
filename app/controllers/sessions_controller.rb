class SessionsController < ApplicationController
  def new
  end
  
  def create
    # TODO: authenticate user
    # find user by email
    @user = User.find_by({ "email" => params["email"] })
    # if no user is found: redirect to `/login` with a `flash` message
    if @user == nil
      flash["notice"] = "Nope."
      redirect_to "/login"
    # if user exists: authenticate (i.e. check) their password
    else
      if BCrypt::Password.new(@user["password"]) == params["password"]
        session["user_id"] = @user["id"]
        flash["notice"] = "Welcome, #{@user["first_name"]}."
        redirect_to "/posts"
      else
        flash["notice"] = "Nope."
        redirect_to "/login"
      end
    end
  end

  def destroy
    # logout a user in the destroy action
    flash["notice"] = "Goodbye."
    session["user_id"] = nil
    redirect_to "/login"
  end


end
