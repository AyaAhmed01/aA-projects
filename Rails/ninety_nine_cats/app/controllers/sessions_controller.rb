class SessionsController < ApplicationController 
    before_action :require_no_user!, except: :destroy

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
            flash.now[:errors] = ["Incorrect username and/or password"]
            render :new 
        end
    end

    def destroy
        logout_user!
        redirect_to new_session_url
    end
end
