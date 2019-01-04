require 'rails_helper'

RSpec.describe "auths/index", type: :view do
  before(:each) do
    assign(:auths, [
      Auth.create!(
        :name => "Name",
        :principal => "Principal"
      ),
      Auth.create!(
        :name => "Name",
        :principal => "Principal"
      )
    ])
  end

  it "renders a list of auths" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Principal".to_s, :count => 2
  end
end
