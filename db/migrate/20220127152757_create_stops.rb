class CreateStops < ActiveRecord::Migration[6.1]
  def change
    create_table :stops do |t|
      t.string :stop_name

      t.timestamps
    end
  end
end
