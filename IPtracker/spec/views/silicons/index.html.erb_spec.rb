require 'spec_helper'

describe "silicons/index" do
  before(:each) do
    assign(:silicons, [
      stub_model(Silicon),
      stub_model(Silicon)
    ])
  end

  it "renders a list of silicons" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
