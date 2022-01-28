require 'zip/filesystem'

namespace :get_data do
  desc "download zip file, open it and save data into database"
  task run_all: [:environment, 'get_data:download_file', 'get_data:unzip_data', 'get_data:store_data']

  task download_file: :environment do
    open('data.zip', 'wb') do |file|
      file << URI.open('http://data.pid.cz/PID_GTFS.zip').read
    end
  end

  task unzip_data: :environment do
    ::Zip::File.open('data.zip') do |zip_file|
      zip_file.each do |file|
        file_path = File.join('data', file.name)
        FileUtils.mkdir_p(File.dirname(file_path))
        zip_file.extract(file, file_path) unless File.exist?(file_path)
      end
    end
    FileUtils.rm('data.zip')
  end

  task store_data: :environment do
    store_stops
    store_routes
    store_trips
    store_stop_times
  end

  def store_stops
    file = File.open("data/stops.txt", "r")
    file.each_line do |line|
      next if file.lineno == 1
      data = line.split(',')
      id, name = data
      Stop.create(:external_id => id, :stop_name => name)
    end
  end

  def store_routes
    file = File.open("data/routes.txt", "r")
    file.each_line do |line|
      next if file.lineno == 1
      data = line.split(',')
      if data[4] == "0"
        id = data[0]
        name = data[2]
        Route.create(:external_id => id, :route_name => name)
      end
    end
  end

  def store_trips
    file = File.open("data/trips.txt", "r")
    file.each_line do |line|
      next if file.lineno == 1

      data = line.split(',')
      route_id, service_id, trip_id = data
      route = Route.find_by_external_id(route_id)
      if route != nil
        Trip.create(external_id: trip_id, service_id: service_id, route_id: route.id)
      end
    end
  end

  def store_stop_times
    file = File.open("data/stop_times.txt", "r")
    file.each_line do |line|
      next if file.lineno == 1

      data = line.split(',')
      trip_id, arrival_time, departure_time, stop_id = data
      trip = Trip.find_by_external_id(trip_id)
      stop = Stop.find_by_external_id(stop_id)
      if trip != nil and stop != nil
        StopTime.create(arrival_time: arrival_time, departure_time: departure_time, trip_id: trip.id, stop_id: stop.id)
      end
    end
  end
end
