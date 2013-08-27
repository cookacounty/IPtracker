require 'spec_helper'

describe Celltracker do

  let(:tracker) { FactoryGirl.create(:user) }
  let(:tracked) { FactoryGirl.create(:cdscell) }
  let(:celltracker) { tracker.celltrackers.build(tracked_id: tracked.id) }

  subject { celltracker }

  it { should be_valid }
  
  describe "tracker methods" do
    it { should respond_to(:tracker) }
    it { should respond_to(:tracked) }
    its(:tracker) { should eq tracker }
    its(:tracked) { should eq tracked }
  end

  describe "when tracked id is not present" do
    before { celltracker.tracked_id = nil }
    it { should_not be_valid }
  end

  describe "when tracker id is not present" do
    before { celltracker.tracker_id = nil }
    it { should_not be_valid }
  end

end
