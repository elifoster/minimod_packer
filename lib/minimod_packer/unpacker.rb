require 'zip'
require 'fileutils'

class MiniModPacker
  module Unpacker
    # Unpacks the given archive into the out directory.
    def unpack
      @simple_file_name = @archive_name.split('/')[-1]
      @output_dir = "#{Dir.pwd}/out/#{@simple_file_name}"
      Zip::File.open(@archive_name) do |file|
        file.each do |entry|
          entry_dir = "#{Dir.pwd}/out/#{@simple_file_name}/#{entry.name}"
          entry.extract(entry_dir)
        end
      end
    end

    # Deletes the unpacked directory.
    def delete
      FileUtils.rm_r(@output_dir)
    end
  end
end
