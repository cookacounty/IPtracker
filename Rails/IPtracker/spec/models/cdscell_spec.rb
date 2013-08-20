require 'spec_helper'

describe Cdscell do
  
  let(:cdslib) { FactoryGirl.create(:cdslib) }
  before { @cdscell = cdslib.cdscells.build(name: "SuperBandgap") }

  subject { @cdscell }

  it { should respond_to(:name) }
  it { should respond_to(:cdslib) }
  it { should respond_to(:cdslib_id) }
  it { should respond_to(:xsize) }
  it { should respond_to(:ysize) }
  it { should respond_to(:area) }
  it { should respond_to(:layimg) }
  
  its(:cdslib) { should eq cdslib }
  
  it { should be_valid }
  
end
