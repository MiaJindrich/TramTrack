class Trip < ApplicationRecord
  belongs_to :route

  def self.get_todays_trips(route_param)
    route_trips = Trip.where("route_id = ?", route_param)
    filtered = Array.new
    route_trips.each do |t|
      if t.service_id[get_day_of_week] == "1"
        filtered << t
      end
    end
    return filtered
  end

  def self.get_day_of_week
    today = Date.today.strftime('%A')
    case today
    when "Monday"
      return 0
    when "Tuesday"
      return 1
    when "Wednesday"
      return 2
    when "Thursday"
      return 3
    when "Friday"
      return 4
    when "Saturday"
      return 5
    else
      return 6
    end
  end

  def get_trip_order
    external_id.split('_')[1]
  end
end
