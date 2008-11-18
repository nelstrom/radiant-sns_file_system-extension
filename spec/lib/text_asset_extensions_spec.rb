require File.dirname(__FILE__) + '/../spec_helper'

describe FileSystem::Model::TextAssetExtensions do
  
  it "should include FileSystem::Model module" do
    [TextAsset, Stylesheet, Javascript].each do |model|
      model.included_modules.should include(FileSystem::Model)
    end
  end
  it "should include FileSystem::Model::TextAssetExtensions module" do
    [TextAsset, Stylesheet, Javascript].each do |model|
      model.included_modules.should include(FileSystem::Model::TextAssetExtensions)
    end
  end
  
end