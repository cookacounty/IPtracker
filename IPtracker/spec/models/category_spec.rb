require 'spec_helper'

describe Category do
  
  let(:category) { FactoryGirl.create(:category) }
  
  subject { category }
  
  it { should respond_to(:name) }
  it { should respond_to(:user) }
  it { should respond_to(:cdscells) }
  it { should respond_to(:cdslibs) } 
  it { should respond_to(:create_from_list) } 
   

  #Add a test for category generation

end
