class ApplicationController < ActionController::Base
    # all your controllers inherit from ApplicationController, so any method here could be 
    # used in any controller.
    # Methods defined on ApplicationController still aren't available in views. 
    # To use them in views, make them helper_methods.
    helper_method :current_user

    def current_user
        return nil if session[:session_token].nil?
        @current_user ||= User.find_by(session_token: session[:session_token])
    end

    def login_user!(user)
        @current_user = user 
        session[:session_token] = user.reset_session_token!
    end

    def logout_user!
        current_user.try(:reset_session_token!)
        session[:session_token] = nil 
    end

    def not_already_signed_in
        redirect_to cats_url if current_user && current_user.session_token == session[:session_token]
    end
end


