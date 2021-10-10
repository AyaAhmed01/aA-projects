class CatsController < ApplicationController
    # redirection inside a before_action cancels further processing of the request
    # if the user is logged in, trying edit/update will get only his OWN cats. So since I validate that
    # ONLY logged in users can edit/update, no need to make ownership validation. We make logging in validation
    # against a malicious user that could make a PUT request directly to /cats/123 using Postman or a similar
    before_action :require_user!, only: %i(edit update new create)  
    def index 
        # fail
        @cats = Cat.all
        render :index 
    end

    def show 
        @cat = Cat.find(params[:id])
        @requests = @cat.cat_rental_requests.order(:start_date)
        render :show 
    end

    def new
        @cat = Cat.new 
        render :new 
    end

    def create 
        # @cat = Cat.new(cat_params)
        # @cat.owner = current_user
        # same:
        @cat = current_user.cats.new(cat_params)
        if @cat.save
            redirect_to cat_url(@cat)
        else
            flash.now[:errors] = @cat.errors.full_messages
            render :new 
        end
    end
    
    def edit 
        user_cats = current_user.cats 
        @cat = user_cats.find(params[:id])
        render :edit 
    end

    def update 
        user_cats = current_user.cats 
        @cat = user_cats.find(params[:id])
        if @cat.update(cat_params)
            redirect_to cat_url(@cat)
        else
            flash.now[:errors] = @cat.errors.full_messages
            render :edit 
        end
    end

    private
    def cat_params
        self.params.require(:cat).permit(:name, :birth_date, :sex, :color, :description)
    end
end
