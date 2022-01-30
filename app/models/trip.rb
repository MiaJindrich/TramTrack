class Trip < ApplicationRecord
  belongs_to :route

  def get_trip_order
    external_id.split('_')[1]
  end
end
