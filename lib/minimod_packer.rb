require_relative 'minimod_packer/unpacker'
require_relative 'minimod_packer/packer'

class MiniModPacker
  include MiniModPacker::Unpacker
  include MiniModPacker::Packer

  # Creates a new instance of the MiniModPacker.
  # @param archive_name [String] The archive to unpack.
  def initialize(archive_name)
    if archive_name.include?('.jar') || archive_name.include?('.zip')
      @archive_name = archive_name
    else
      @archive_name = "#{archive_name}.zip"
    end

    @dirs = {
      'decor' => [
        'assets/santasdecor',
        'santa/decor'
      ],
      'freedom' => [
        'assets/santafreedom',
        'santa/freedom'
      ],
      'pants' => [
        'assets/sparklypants',
        'santa/pants'
      ],
      'toys' => [
        'assets/santastoys',
        'santa/toys'
      ]
    }
  end
end
