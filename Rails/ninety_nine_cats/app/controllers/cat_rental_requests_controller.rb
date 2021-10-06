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

    private 

    def request_params
        params[:cat_rental_request].permit(:start_date, :end_date, :status, :cat_id)
    end
end