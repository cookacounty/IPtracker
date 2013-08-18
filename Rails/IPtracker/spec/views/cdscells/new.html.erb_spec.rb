require 'spec_helper'

describe "cdscells/new" do
  before(:each) do
    assign(:cdscell, stub_model(Cdscell,
      :name => "MyString",
      :cdslib_id => 1
    ).as_new_record)
  end

  it "renders new cdscell form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", cdscells_path, "post" do
      assert_select "input#cdscell_name[name=?]", "cdscell[name]"
      assert_select "input#cdscell_cdslib_id[name=?]", "cdscell[cdslib_id]"
    end
  end
end
