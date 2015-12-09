require 'zip'

class MiniModPacker
  module Packer
    # Packs all of the relevant files into a zip.
    # @param mod [String] Which mod key being used.
    # @return [void]
    def pack(mod)
      @dirs[mod].each do |dir|
        full_dir = "#{Dir.pwd}/out/#{@simple_file_name}/#{dir}"
        Zip::File.open("#{Dir.pwd}/out/#{mod}.zip", Zip::File::CREATE) do |zip|
          add_from_dir(full_dir, dir, zip)
        end
      end
    end

    # Adds all of the files into the directory. Gets recursively called when a
    #   file in the directory is a sub-directory.
    # @param dir [String] The full directory
    # @param small_dir [String] The "small" directory, or whatever will be
    #   actually inside of the zip. This is essentially zip/#{small_dir}.
    # @param zip [Zip::File] The zip file being created.
    # @return [void]
    def add_from_dir(dir, small_dir, zip)
      Dir.foreach(dir) do |item|
        next if item == '.'
        next if item == '..'
        full_item = "#{dir}/#{item}"
        f = File.new(full_item, 'r')
        if File.file?(f)
          zip.add("#{small_dir}/#{item}", full_item)
        elsif File.directory?(f)
          zip.mkdir("#{small_dir}/#{item}") unless File.exist?(item)
          add_from_dir(full_item, "#{small_dir}/#{item}", zip)
        end
      end
    end
  end
end
