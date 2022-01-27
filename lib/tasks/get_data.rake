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
end
