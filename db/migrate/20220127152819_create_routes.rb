class CreateRoutes < ActiveRecord::Migration[6.1]
  def change
    create_table :routes do |t|
      t.string :external_id
      t.string :route_name

      t.timestamps
    end
  end
end
