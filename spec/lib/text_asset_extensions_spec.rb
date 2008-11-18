require File.dirname(__FILE__) + '/../spec_helper'

class MockModel
  def self.class_of_active_record_descendant(klass)
    MockModel
  end
end

class MockSubclass < MockModel
end

describe TextAsset do
  
  before :each do
    # @text_asset = mock("TextAsset")
    MockModel.send :include, FileSystem::Model
    MockModel.send :include, FileSystem::Model::TextAssetExtensions
    @model = MockModel.new
  end
  
  it "should include FileSystem::Model module" do
    TextAsset.included_modules.should include(FileSystem::Model)
  end
  it "should include FileSystem::Model::TextAssetExtensions module" do
    TextAsset.included_modules.should include(FileSystem::Model::TextAssetExtensions)
  end
  
  it "should have class methods" do
    [:path, :load_files, :save_files].each do |m|
      MockModel.should respond_to(m)
    end
  end
  
  it "should have instance methods" do
    @model.should respond_to(:load_file)
    @model.should respond_to(:save_file)
    @model.should respond_to(:filename)
  end
  
end