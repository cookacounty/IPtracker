require 'spec_helper'

describe Cdslib do
  before do
    @cdslib = Cdslib.new(name: "Example Library")
  end    
  
  subject { @cdslib }

  it { should respond_to(:name) }
  
  it { should be_valid }
end
