require File.dirname(__FILE__) + '/../spec_helper'

class MockStyles
  def self.class_of_active_record_descendant(klass)
    MockStyles
  end
end

describe Stylesheet do
  
  before :each do
    MockStyles.send :include, FileSystem::Model
    MockStyles.send :include, FileSystem::Model::TextAssetExtensions
    MockStyles.send :include, FileSystem::Model::StylesheetExtensions
    @model = MockStyles.new
  end
  
  it "should include FileSystem::Model module" do
    Stylesheet.included_modules.should include(FileSystem::Model)
  end
  it "should include FileSystem::Model::TextAssetExtensions module" do
    Stylesheet.included_modules.should include(FileSystem::Model::TextAssetExtensions)
  end
  it "should include FileSystem::Model::StylesheetExtensions module" do
    Stylesheet.included_modules.should include(FileSystem::Model::StylesheetExtensions)
  end
  
  it "should have class methods" do
    [:path, :load_files, :save_files].each do |m|
      MockStyles.should respond_to(m)
    end
  end
  
  it "should have instance methods" do
    @model.should respond_to(:load_file)
    @model.should respond_to(:save_file)
    @model.should respond_to(:filename)
  end
  
  it "should use 'Stylesheet' as klass_name" do
    MockStyles.klass_name.should == "Stylesheet"
  end
  
  describe "filename" do
    it "should use '.css' as default extension" do
      class << @model
        attr_accessor :name
      end
      @model.name = "pacman"
      @model.filename.should == "#{RAILS_ROOT}/design/stylesheets/pacman.css"
    end
  end
  
end