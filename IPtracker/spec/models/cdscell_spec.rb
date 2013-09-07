require 'spec_helper'

describe Cdscell do
  
  let(:cdslib) { FactoryGirl.create(:cdslib) }
  
  before do
    @cdscell = Cdscell.new(name: "SuperBandgap", area: 100, ysize: 20, xsize: 30, cdslib: cdslib)
  end

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
  
  #Silicon Tracker
  it { should respond_to(:silicontrackers) }
  it { should respond_to(:silicons) }
  it { should respond_to(:add_silicon!) }
  it { should respond_to(:rm_silicon!) }
  it { should respond_to(:used_in_silicon?) }
  
  #Categories
  it {should respond_to(:categories)}
  it {should respond_to(:in_category?)}
  it {should respond_to(:add_category!)}
  it {should respond_to(:rm_category!)}

  #Need to fix this test
  #its(:cdslib) { should eq cdslib }
  
  it { should be_valid }
  
  #Celltracker
  describe "tracking silicon" do
    let(:silicon) { FactoryGirl.create(:silicon) }
    before do
      @cdscell.save!
      @cdscell.add_silicon!(silicon)
    end

    it { should be_used_in_silicon(silicon) }
    its(:silicons) { should include(silicon) }

    describe "and in silicon" do
      subject { silicon }
      its(:cdscells) { should include(@cdscell) }
    end

    describe "and not tracking" do
      
      before { @cdscell.rm_silicon!(silicon) }
      
      subject { @cdscell }
      
      it { should_not be_used_in_silicon(silicon) }
      its(:silicons) { should_not include(silicon) }
    end
        
    #describe "and deleted" do
    #  before{@user.destroy!}
    #  
    #  subject{ cell }
    #  its(:trackers) { should_not include(@user) }
    #end
    
  end
  
  describe "adding cell to category" do
    let(:category) { FactoryGirl.create(:category) }
    before do
      @cdscell.save!
      @cdscell.add_category!(category)
    end
    
    subject { @cdscell }

    it { should be_in_category(category) }
    its(:categories) { should include(category) }

    describe "and then removed from category" do
      
      before { @cdscell.rm_category!(category) }
      
      subject { @cdscell }
      
      it { should_not be_in_category(category) }
      its(:categories) { should_not include(category) }
    end
  end
  
  
  #Test that a category list can be assigned
  
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
