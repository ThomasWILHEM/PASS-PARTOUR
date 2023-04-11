class FlightsController < ApplicationController
  def index
    @flights = Flight.all
  end

  def show
  end

  def new
  end

  def edit
  end
end
