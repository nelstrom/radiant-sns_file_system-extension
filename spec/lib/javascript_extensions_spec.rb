require File.dirname(__FILE__) + '/../spec_helper'

class MockModel
  def self.class_of_active_record_descendant(klass)
    MockModel
  end
end

describe Javascript do
  
  before :each do
    MockModel.send :include, FileSystem::Model
    MockModel.send :include, FileSystem::Model::TextAssetExtensions
    MockModel.send :include, FileSystem::Model::JavascriptExtensions
    @model = MockModel.new
  end
  
  it "should include FileSystem::Model module" do
    Javascript.included_modules.should include(FileSystem::Model)
  end
  it "should include FileSystem::Model::TextAssetExtensions module" do
    Javascript.included_modules.should include(FileSystem::Model::TextAssetExtensions)
  end
  it "should include FileSystem::Model::JavascriptExtensions module" do
    Javascript.included_modules.should include(FileSystem::Model::JavascriptExtensions)
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
  
  it "should use 'Javascript' as klass_name" do
    MockModel.klass_name.should == "Javascript"
  end
  
  describe "filename" do
    it "should use '.js' as default extension" do
      class << @model
        attr_accessor :name
      end
      @model.name = "space_invaders"
      @model.filename.should == "#{RAILS_ROOT}/design/javascripts/space_invaders.js"
    end
  end
end