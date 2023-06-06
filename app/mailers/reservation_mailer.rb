class ReservationMailer < ApplicationMailer
  default from: 'informations@pass-partour.com'

  def reservation_confirmation(reservation, flight, user)
    @reservation = reservation
    @flight = flight
    @user = user
    mail(to: @user.email, subject: "Confirmation de réservation - Numéro #{@reservation.pnr}")
  end
end