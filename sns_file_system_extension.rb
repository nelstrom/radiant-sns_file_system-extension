class SnsFileSystemExtension < Radiant::Extension
  version "0.1"
  description "Extend SnS with file_system functionality."
  url "http://github.com/nelstrom/radiant-sns_file_system-extension/"
  
  def activate
    raise "The SnS_file_system extension requires the Styles 'n Scripts extension be available" unless defined?(SnsExtension)
    raise "The SnS_file_system extension requires the Styles 'n Scripts extension be available" unless defined?(FileSystemExtension)
    begin
      FileSystem::MODELS << "TextAsset" << "Javascript" << "Stylesheet"
    rescue NameError, LoadError
    end
  end
  
  def deactivate
  end
  
end