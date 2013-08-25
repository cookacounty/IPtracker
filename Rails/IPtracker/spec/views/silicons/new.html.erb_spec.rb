require 'spec_helper'

describe "silicons/new" do
  before(:each) do
    assign(:silicon, stub_model(Silicon).as_new_record)
  end

  it "renders new silicon form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", silicons_path, "post" do
    end
  end
end
