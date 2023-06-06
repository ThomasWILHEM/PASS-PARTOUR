class FlightsController < ApplicationController
  def index
    @flights = Flight.page(params[:page])
  end

  def show
  end

  def new
  end

  def edit
  end
end
