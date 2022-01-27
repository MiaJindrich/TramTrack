class CreateStopTimes < ActiveRecord::Migration[6.1]
  def change
    create_table :stop_times do |t|
      t.string :arrival_time
      t.string :departure_time
      t.references :trip, null: false, foreign_key: true
      t.references :stop, null: false, foreign_key: true

      t.timestamps
    end
  end
end
