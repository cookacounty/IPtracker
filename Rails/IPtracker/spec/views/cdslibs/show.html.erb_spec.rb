require 'spec_helper'

describe "cdslibs/show" do
  before(:each) do
    @cdslib = assign(:cdslib, stub_model(Cdslib,
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
  end
end
