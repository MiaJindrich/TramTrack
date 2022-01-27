namespace :get_data do
  desc "download zip file, open it and save data into database"
  task run_all: [:environment, 'get_data:download_file', 'get_data:parse_data']

  task download_file: :environment do
    open('data.zip', 'wb') do |file|
      file << URI.open('http://data.pid.cz/PID_GTFS.zip').read
    end
  end

  task parse_data: :environment do

  end
end
