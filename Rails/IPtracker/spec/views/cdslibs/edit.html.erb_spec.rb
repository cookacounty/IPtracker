require 'spec_helper'

describe "cdslibs/edit" do
  before(:each) do
    @cdslib = assign(:cdslib, stub_model(Cdslib,
      :name => "MyString"
    ))
  end

  it "renders the edit cdslib form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", cdslib_path(@cdslib), "post" do
      assert_select "input#cdslib_name[name=?]", "cdslib[name]"
    end
  end
end
