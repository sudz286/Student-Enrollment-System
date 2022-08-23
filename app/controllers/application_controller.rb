class ApplicationController < ActionController::Base
    helper_method :logged_in?, :current_user, :authorized

    # Something in session hash? Return logged in user if hash has val
    def current_user
        if session[:user_id]
            @user = User.find(session[:user_id])
        end
    end

    def logged_in?
        !!current_user # This syntax forces a Boolean conversion
    end

    # A macro for keeping anyone unauthenticated from doing anything
    def authorized
        if !logged_in?
            flash.alert = "You have to be logged in to do that."
            redirect_to login_path
        end
    end
end
