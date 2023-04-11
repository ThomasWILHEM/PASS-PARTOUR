class CreateReservations < ActiveRecord::Migration[7.0]
  def change
    create_table :reservations do |t|
      t.references :user, null: false, foreign_key: true
      t.references :flight, null: false, foreign_key: true
      t.integer :count

      t.timestamps
    end
  end
end
