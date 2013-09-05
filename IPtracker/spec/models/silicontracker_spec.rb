require 'spec_helper'

describe Silicontracker do

  before(:each) do
    @cdscell = FactoryGirl.create(:cdscell)
    @silicon = FactoryGirl.create(:silicon)
    @silicontracker = @cdscell.silicontrackers.build(silicon_id: @silicon.id)
  end
    
  subject { @silicontracker }

  it { should be_valid }

  describe "methods" do
    it { should respond_to(:cdscell) }
    it { should respond_to(:silicon) }
    its(:cdscell) { should eq @cdscell }
    its(:silicon) { should eq @silicon }
  end
  
  describe "when silicon id is not present" do
    before { @silicontracker.silicon_id = nil }
    it { should_not be_valid }
  end

  describe "when cdscell id is not present" do
    before { @silicontracker.cdscell_id = nil }
    it { should_not be_valid }
  end

  
end