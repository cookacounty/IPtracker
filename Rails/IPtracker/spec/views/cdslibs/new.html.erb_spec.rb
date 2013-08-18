require 'spec_helper'

describe "cdslibs/new" do
  before(:each) do
    assign(:cdslib, stub_model(Cdslib,
      :name => "MyString"
    ).as_new_record)
  end

  it "renders new cdslib form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", cdslibs_path, "post" do
      assert_select "input#cdslib_name[name=?]", "cdslib[name]"
    end
  end
end
