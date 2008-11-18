require File.dirname(__FILE__) + '/../spec_helper'


describe Javascript do
  
  it "should include FileSystem::Model module" do
    Javascript.included_modules.should include(FileSystem::Model)
  end
  it "should include FileSystem::Model::TextAssetExtensions module" do
    Javascript.included_modules.should include(FileSystem::Model::TextAssetExtensions)
  end
  it "should include FileSystem::Model::JavascriptExtensions module" do
    Javascript.included_modules.should include(FileSystem::Model::JavascriptExtensions)
  end
  
end