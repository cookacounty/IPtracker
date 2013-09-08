require 'spec_helper'

describe Category do
  
  let(:category) { FactoryGirl.create(:category) }
  
  subject { category }
  
  it { should respond_to(:name) }
  it { should respond_to(:user) }
  it { should respond_to(:cdscells) }
  it { should respond_to(:cdslibs) } 
   

  #Test that it creates from list
  #Test
  describe ".create_from_list" do
    it "should exist" do
      #Category.create_from_list.should == true
    end
  end
  
  #Add a test for category generation

end
