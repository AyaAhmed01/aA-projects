class SessionsController < ApplicationController 
    before_action :not_already_signed_in, only: :create  

    def new
        render :new  
    end

    def create
        # verify username and password
        @user = User.find_by_credentials(params[:user][:user_name], params[:user][:password])
        if @user 
            login_user!(@user) 
            redirect_to cats_url
        else
            flash.now[:errors] ||= []
            flash.now[:errors] << "Incorrect user name or password"
            render :new 
        end
    end

    def destroy
        logout_user!
        redirect_to new_session_url
    end
end
