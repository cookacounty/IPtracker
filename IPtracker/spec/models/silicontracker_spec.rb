require 'spec_helper'

describe Silicontracker do

  let(:cdscell) { FactoryGirl.create(:cdscell) }
  let(:silicon) { FactoryGirl.create(:silicon) }
  let(:silicontracker) { cdscell.silicontrackers.build(silicon_id: silicon.id) }

  subject { silicontracker }

  it { should be_valid }
  

  describe "methods" do
    it { should respond_to(:cdscell) }
    it { should respond_to(:silicon) }
    its(:cdscell) { should eq cdscell }
    its(:silicon) { should eq silicon }
  end
  
  describe "when silicon id is not present" do
    before { silicontracker.silicon_id = nil }
    it { should_not be_valid }
  end

  describe "when cdscell id is not present" do
    before { silicontracker.cdscell_id = nil }
    it { should_not be_valid }
  end

  
end