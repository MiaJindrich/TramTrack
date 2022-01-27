require 'zip/filesystem'

namespace :get_data do
  desc "download zip file, open it and save data into database"
  task run_all: [:environment, 'get_data:download_file', 'get_data:unzip_data']

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
    # store_stops
    store_routes

  end

  def store_stops
    file = File.open("data/stops.txt", "r")
    file.each_line do |line|
      next if file.lineno == 1
      data = line.split(',')
      id = data[0]
      name = data[1]
      s = Stop.new(:external_id => id, :stop_name => name)
      s.save
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
        r = Route.new(:external_id => id, :route_name => name)
        r.save
      end
    end
  end
end
