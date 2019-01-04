require 'rails_helper'

RSpec.describe "auths/edit", type: :view do
  before(:each) do
    @auth = assign(:auth, Auth.create!(
      :name => "MyString",
      :principal => "MyString"
    ))
  end

  it "renders the edit auth form" do
    render

    assert_select "form[action=?][method=?]", auth_path(@auth), "post" do

      assert_select "input[name=?]", "auth[name]"

      assert_select "input[name=?]", "auth[principal]"
    end
  end
end
