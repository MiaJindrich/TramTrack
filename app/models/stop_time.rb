class StopTime < ApplicationRecord
  belongs_to :trip
  belongs_to :stop

  def self.filter_stop_time(time_param, trip_param)
    time = Time.strptime(time_param, "%H:%M")
    stop_time_by_trip_id = StopTime.where("trip_id = ?", trip_param)
    stop_time_by_trip_id_new = StopTime.where("trip_id = ?", trip_param)
    filtered = Array.new
    stop_time_by_trip_id.each do |s|
      arr_time = convert_time(s.arrival_time)
      dep_time = convert_time(s.departure_time)
      if time >= arr_time and time <= dep_time
        filtered << s
      end
    end
    if filtered.length == 0
      unified_time = unify_time_format(time_param)
      last_stop = stop_time_by_trip_id.where("departure_time < ?", unified_time).order(departure_time: :desc).first
      next_stop = stop_time_by_trip_id_new.where("arrival_time > ?", unified_time).order(arrival_time: :asc).first

      filtered << last_stop
      filtered << next_stop
    end
    return filtered
  end

  def self.convert_time(time)
    Time.strptime(time, "%H:%M:%S")
  end

  def self.unify_time_format(time)
    time[0] == "0" ? time[1..-1] : time
  end
end