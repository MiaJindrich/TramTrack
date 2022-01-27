class CreateTrips < ActiveRecord::Migration[6.1]
  def change
    create_table :trips do |t|
      t.string :external_id
      t.string :service_id
      t.references :route, null: false, foreign_key: true

      t.timestamps
    end
  end
end
