class CatRentalRequestsController < ApplicationController
    def new 
        @cats = Cat.all 
        render :new 
    end

    def create
        @rental_request = CatRentalRequest.new(request_params)
        if @rental_request.save
            redirect_to cat_url(@rental_request.cat)
        else
            flash.now[:errors] = @rental_request.errors.full_messages
            render :new 
        end
    end

    def approve 
        current_cat_rental_request.approve!
        redirect_to cat_url(current_cat_rental_request.cat)
    end

    def deny 
        current_cat_rental_request.deny!
        redirect_to cat_url(current_cat_rental_request.cat)
    end


    private 

    def current_cat_rental_request
        @rental_request = CatRentalRequest.find(params[:id])
    end

    def request_params
        params[:cat_rental_request].permit(:start_date, :end_date, :status, :cat_id)
    end
end