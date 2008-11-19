require File.dirname(__FILE__) + '/../spec_helper'

class MockModel
  def self.class_of_active_record_descendant(klass)
    MockModel
  end
end

class MockSubclass < MockModel
end

def mock_filepath
  "#{RAILS_ROOT}/design/mock_models"
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
  
  # ----------------
  describe "filename" do
    
    it "should use name with default extension" do
      class << @model
        attr_accessor :name
      end
      @model.name = "hit me"
      @model.filename.should == "#{RAILS_ROOT}/design/mock_models/hit me.html"
    end
  
    it "should use record name, which may include its own extension" do
      class << @model
        attr_accessor :name
      end
      @model.name = "myfile.txt"
      @model.filename.should == "#{RAILS_ROOT}/design/mock_models/myfile.txt.html"
    end
  
    it "should use custom filter as extension" do
      class << @model
        attr_accessor :name, :filter_id
      end
      @model.name = "hit me"
      @model.filter_id = "txt"
      @model.filename.should == "#{RAILS_ROOT}/design/mock_models/hit me.txt"
    end
  
    it "should include .min when minified" do
      class << @model
        attr_accessor :name, :minify
      end
      @model.name = "myfile"
      @model.minify = true
      @model.filename.should == "#{RAILS_ROOT}/design/mock_models/myfile.min.html"
    end
  
    it "should not include .min when not minified" do
      class << @model
        attr_accessor :name, :minify
      end
      @model.name = "myfile"
      @model.minify = false
      @model.filename.should == "#{RAILS_ROOT}/design/mock_models/myfile.html"
    end
  
    it "should use name(.min).extension when provided with all 3" do
      class << @model
        attr_accessor :name, :filter_id, :minify
      end
      @model.name = "myfile"
      @model.filter_id = "markdown"
      @model.minify = true
      @model.filename.should == "#{RAILS_ROOT}/design/mock_models/myfile.min.markdown"
    end
  end
  
  describe "load_file" do
    before(:each) do
      class << @model
        attr_accessor :name, :content
      end
      @model.content = "Original content in the database"
      @file_mock = mock("file_mock")
      @file_mock.should_receive(:read).and_return("Content stored in a file")
    end
    
    it "should update content with file contents" do
      @model.should_receive(:open).with("typography.min.html").and_return(@file_mock)
      @model.load_file("typography.min.html")
      @model.content.should == "Content stored in a file"
    end
    
    it "should set minify to true when filename contains .min" do
      class << @model
        attr_accessor :minify
      end
      @model.minify = false
      @model.should_receive(:open).with("typography.min.html").and_return(@file_mock)
      @model.load_file("typography.min.html")
      @model.minify.should be_true
    end
    
    it "should set minify to false when filename doesn't contains .min" do
      class << @model
        attr_accessor :minify
      end
      @model.minify = true
      @model.should_receive(:open).with("typography.html").and_return(@file_mock)
      @model.load_file("typography.html")
      @model.minify.should be_false
    end
    
    it "should set filter_id to nil when filename uses default extension" do
      class << @model
        attr_accessor :filter_id
      end
      @model.filter_id = "Textile"
      @model.should_receive(:open).with("typography.min.html").and_return(@file_mock)
      @model.load_file("typography.min.html")
      @model.filter_id.should be_nil
    end
    
    it "should set filter_id to the file extension, when not using default" do
      class << @model
        attr_accessor :filter_id
      end
      @model.filter_id = nil
      @model.should_receive(:open).with("typography.min.textile").and_return(@file_mock)
      @model.load_file("typography.min.textile")
      @model.filter_id.should == "Textile"
    end
    
  end
  
end