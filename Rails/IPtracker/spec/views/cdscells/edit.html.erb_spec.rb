require 'spec_helper'

describe "cdscells/edit" do
  before(:each) do
    @cdscell = assign(:cdscell, stub_model(Cdscell,
      :name => "MyString",
      :cdslib_id => 1
    ))
  end

  it "renders the edit cdscell form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", cdscell_path(@cdscell), "post" do
      assert_select "input#cdscell_name[name=?]", "cdscell[name]"
      assert_select "input#cdscell_cdslib_id[name=?]", "cdscell[cdslib_id]"
    end
  end
end
