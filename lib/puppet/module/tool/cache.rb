module Puppet::Module::Tool

  class Cache
    include Puppet::Module::Tool::Utils::URI

    def initialize(repository)
      @repository = repository
    end

    # TODO: Checksum support
    def retrieve(url)
      filename = File.basename(url.to_s)
      cached_file = path + filename
      unless cached_file.file?
        if url.scheme == 'file'
          FileUtils.cp(url.path, cached_file)
        else
          # TODO: Handle HTTPS
          uri = normalize(url)
          data = uri.read
          cached_file.open('wb') { |f| f.write data }
          data
        end
      end
      cached_file
    end

    def path
      @path ||=
        begin
          path = Puppet::Module::Tool.pmtdir + 'cache' + @repository.cache_key
          path.mkpath
          path
        end
    end

  end

end
