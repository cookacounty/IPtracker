require 'spec_helper'

describe "silicons/show" do
  before(:each) do
    @silicon = assign(:silicon, stub_model(Silicon))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
