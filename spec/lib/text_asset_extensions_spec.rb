require File.dirname(__FILE__) + '/../spec_helper'

describe TextAsset do
  
  it "should include FileSystem::Model module" do
    TextAsset.included_modules.should include(FileSystem::Model)
  end
  it "should include FileSystem::Model::TextAssetExtensions module" do
    TextAsset.included_modules.should include(FileSystem::Model::TextAssetExtensions)
  end
  
end