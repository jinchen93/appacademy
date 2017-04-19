class CatRentalRequestsController < ApplicationController
  def new
    @cats = Cat.all
    render :new
  end

  def create
    rental_request = CatRentalRequest.new(cat_rental_params)

    if rental_request.save
      redirect_to cat_url(id: rental_request[:cat_id])
    else
      render text: rental_request.errors.full_messages
    end
  end

  def deny
    rental = CatRentalRequest.find_by(id: params[:id])
    rental.deny!
    redirect_to :back
  end

  def approve
    rental = CatRentalRequest.find_by(id: params[:id])
    rental.approve!
    redirect_to :back
  end

  private

  def cat_rental_params
    params.require(:rental).permit(:cat_id, :start_date, :end_date)
  end
end
