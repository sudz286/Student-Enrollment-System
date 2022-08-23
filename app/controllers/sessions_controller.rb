class SessionsController < ApplicationController
    def new
        # No reason to be here if you're already logged in
        # So redirect to the show page
        redirect_to current_user if logged_in?
        # Otherwise just return the login form
    end

    def create
        # Try to find the user via email from login form
        @user = User.find_by(email: params[:email])

        if !@user
            flash.alert = "The email and password combination you provided was not valid."
            redirect_to login_path and return
        end

        if @user && @user.authenticate(params[:password])
            # Authenticated with valid password
            # Store authenticated user in session
            session[:user_id] = @user.id

            # redirect to user's show page
            flash.notice = "You have successfully logged in."
            redirect_to @user
        else
            # Back to login form
            flash.alert = "The email and password combination you provided was not valid."
            redirect_to login_path
        end
    end

    def destroy
        # Remove session cookie!
        session[:user_id] = nil
        # Can't do anything with app unless you log in, so
        # back to login form
        flash.notice = "You have successfully logged out."
        redirect_to login_path
    end
end