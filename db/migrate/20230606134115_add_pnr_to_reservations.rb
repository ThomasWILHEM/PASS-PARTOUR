class AddPnrToReservations < ActiveRecord::Migration[7.0]
  def change
    add_column :reservations, :pnr, :string
  end
end
