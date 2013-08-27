require 'spec_helper'

describe Silicon do
  before do
    @silicon = Silicon.new(name: "1234AA")
  end    
  
  subject { @silicon }

  it { should respond_to(:name) }
  
  #Silicon Tracker
  it { should respond_to(:silicontrackers) }
  it { should respond_to(:cdscells) }
  
  it { should be_valid }
  
  describe "with bad die name" do
    it "should be invalid" do
      names = %w[asdf  1243adf easdf134]
      names.each do |invalid_name|
        @silicon.name = invalid_name
        expect(@silicon).not_to be_valid
      end
    end
  end
end
