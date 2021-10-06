class CatsController < ApplicationController 
    def index 
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
        @cat = Cat.new(cat_params)
        if @cat.save
            redirect_to cat_url(@cat)
        else
            flash.now[:errors] = @cat.errors.full_messages
            render :new 
        end
    end

    def edit 
        @cat = Cat.find(params[:id])
        render :edit 
    end

    def update 
        @cat = Cat.find(params[:id])
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