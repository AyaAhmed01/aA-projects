class UsersController < ApplicationController 
    before_action :not_already_signed_in, only: :create  
    def new 
        @user = User.new 
    end

    def create 
        @user = User.new(user_params)
        if @user.save
            login_user!(@user)     # helper method in application_controller
            redirect_to cats_url
        else
            flash.now[:errors] ||=[]
            flash.now[:errors] << @user.errors.full_messages
            render :new 
        end
    end

    private 
    def user_params
        params.require(:user).permit(:user_name, :password)
    end
end
