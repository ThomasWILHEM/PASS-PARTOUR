class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :flight

  validate :check_seat_availability

  def check_seat_availability
    if seat_class == "Economy"
      if flight.economy_seats_available < seat_count
        errors.add(:base, "There are not enough economy seats available for this flight.")
      else
        flight.update(economy_seats_available: flight.economy_seats_available - seat_count)
      end
    elsif seat_class == "Business"
      if flight.business_seats_available < seat_count
        errors.add(:base, "There are not enough business seats available for this flight.")
      else
        flight.update(business_seats_available: flight.business_seats_available - seat_count)
      end
    end
  end
end