class UsersController < ApplicationController
    def index
        render json: User.all 
    end

    def show 
        render json: User.find(params[:id])
    end

    def create
        user = User.new(user_params)
        if user.save
            render json: user
        else
            render json: user.errors.full_messages
        end
    end

    def update
        user = User.find(params[:id])
        user.update(user_params)
        render json: user
    end

    def destroy
    end

    private
    def user_params
        params[:user].permit(:name, :email)
    end
end