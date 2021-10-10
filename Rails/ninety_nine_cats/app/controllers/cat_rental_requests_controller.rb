class CatRentalRequestsController < ApplicationController
    before_action :require_user!, only: %i(approve deny)
    before_action :require_cat_ownership!, only: %i(approve deny)

    def new 
        @cats = Cat.all 
        render :new 
    end

    def create
        @rental_request = CatRentalRequest.new(request_params)
        @rental_request.requester = current_user    
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
        @rental_request ||= CatRentalRequest.includes(:cat).find(params[:id]) # use includes to solve N+1 problem
    end

    def current_cat
        current_cat_rental_request.cat   # won't fire another DB query 
    end

    def require_cat_ownership!
        unless current_user.owns_cat?(curren_cat)
            redirect_to cat_url(current_cat)
        end
    end

    def request_params
        params[:cat_rental_request].permit(:start_date, :end_date, :status, :cat_id)
    end
end