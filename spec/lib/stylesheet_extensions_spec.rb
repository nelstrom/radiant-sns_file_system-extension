require File.dirname(__FILE__) + '/../spec_helper'

describe Stylesheet do
  
  it "should include FileSystem::Model module" do
    Stylesheet.included_modules.should include(FileSystem::Model)
  end
  it "should include FileSystem::Model::TextAssetExtensions module" do
    Stylesheet.included_modules.should include(FileSystem::Model::TextAssetExtensions)
  end
  it "should include FileSystem::Model::StylesheetExtensions module" do
    Stylesheet.included_modules.should include(FileSystem::Model::StylesheetExtensions)
  end
  
end