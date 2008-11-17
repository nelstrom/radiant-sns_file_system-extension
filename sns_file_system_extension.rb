# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class SnsFileSystemExtension < Radiant::Extension
  version "1.0"
  description "Describe your extension here"
  url "http://yourwebsite.com/sns_file_system"
  
  # define_routes do |map|
  #   map.connect 'admin/sns_file_system/:action', :controller => 'admin/sns_file_system'
  # end
  
  def activate
    # admin.tabs.add "Sns File System", "/admin/sns_file_system", :after => "Layouts", :visibility => [:all]
  end
  
  def deactivate
    # admin.tabs.remove "Sns File System"
  end
  
end