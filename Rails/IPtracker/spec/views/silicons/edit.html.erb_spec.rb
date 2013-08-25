require 'spec_helper'

describe "silicons/edit" do
  before(:each) do
    @silicon = assign(:silicon, stub_model(Silicon))
  end

  it "renders the edit silicon form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", silicon_path(@silicon), "post" do
    end
  end
end
