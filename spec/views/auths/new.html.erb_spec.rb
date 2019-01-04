require 'rails_helper'

RSpec.describe "auths/new", type: :view do
  before(:each) do
    assign(:auth, Auth.new(
      :name => "MyString",
      :principal => "MyString"
    ))
  end

  it "renders new auth form" do
    render

    assert_select "form[action=?][method=?]", auths_path, "post" do

      assert_select "input[name=?]", "auth[name]"

      assert_select "input[name=?]", "auth[principal]"
    end
  end
end
