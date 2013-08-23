require 'spec_helper'

describe Cdscell do
  
  let(:cdslib) { FactoryGirl.create(:cdslib) }
  
  before { @cdscell = cdslib.cdscells.build(name: "SuperBandgap", area: 100, ysize: 20, xsize: 30) }

  subject { @cdscell }

  it { should respond_to(:name) }
  it { should respond_to(:cdslib) }
  it { should respond_to(:cdslib_id) }
  it { should respond_to(:xsize) }
  it { should respond_to(:ysize) }
  it { should respond_to(:area) }
  
  #Cell Tracker
  it { should respond_to(:celltrackers) }
  it { should respond_to(:trackers) }
  
  its(:cdslib) { should eq cdslib }
  
  it { should be_valid }
  
  #Test that cdslib id is correct
  
  #Test that cdslib destroys cell
  
  #Test tracked
  #describe "tracked" do
    #let(:user  ) { FactoryGirl.create(:user)   }
    #let(:cell  ) { FactoryGirl.create(:cdscell)   }

    #before do
    #  user.save
    #  user.track!(cell)
    #end
    
    #describe "and deleted" do
    #  before { cell.destroy! }
    #  
    #  subject{user}
    #  it { should_not be_tracking(cell) }
    #  its(:tracked_cells) { should_not include(cell) }
    #end
    
  #end
  
end
