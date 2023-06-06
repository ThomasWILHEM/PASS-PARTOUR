class ReservationsController < ApplicationController
  before_action :set_reservation, only: %i[ show edit update destroy ]
  before_action :authenticate_user!

  # GET /reservations or /reservations.json
  def index
    @reservations = Reservation.all
  end

  # GET /reservations/1 or /reservations/1.json
  def show
  end



  # GET /reservations/1/edit
  def edit
  end

  # GET /reservations/new
  def new
    @reservation = Reservation.new
    @flight = Flight.find(params[:flight_id])
  end

  def create
    @reservation = current_user.reservations.build(reservation_params)
    @flight = Flight.find(params[:reservation][:flight_id])
    @user = current_user
    seat_type = params[:reservation][:seat_class]

    if seat_type == 'business'
      if @flight.business_class_seats < @reservation.count
        @reservation.errors.add(:count, "Not enough available seats in business class.")
        render :new and return
      end
      @flight.update(business_class_seats: @flight.business_class_seats - @reservation.count)
    elsif seat_type == 'economy'
      if @flight.economy_class_seats < @reservation.count
        @reservation.errors.add(:count, "Not enough available seats in economy class.")
        render :new and return
      end
      @flight.update(economy_class_seats: @flight.economy_class_seats - @reservation.count)
    end

    if @reservation.save
      ReservationMailer.reservation_confirmation(@reservation, @flight, @user).deliver_now
      redirect_to @reservation, notice: 'Reservation was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /reservations/1 or /reservations/1.json
  def update
    respond_to do |format|
      if @reservation.update(reservation_params)
        format.html { redirect_to reservation_url(@reservation), notice: "Reservation was successfully updated." }
        format.json { render :show, status: :ok, location: @reservation }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reservations/1 or /reservations/1.json
  def destroy
    @reservation = Reservation.find(params[:id])
    flight = @reservation.flight

    # Mise à jour des places du vol en ajoutant les places de la réservation supprimée
    if @reservation.seat_class == 'business'
      flight.business_class_seats += @reservation.count
    elsif @reservation.seat_class == 'economy'
      flight.economy_class_seats += @reservation.count
    end

    flight.save

    @reservation.destroy

    respond_to do |format|
      format.html { redirect_to reservations_url, notice: "Reservation was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reservation
      @reservation = Reservation.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def reservation_params
      params.require(:reservation).permit(:user_id, :flight_id, :count, :seat_class)
    end
end
