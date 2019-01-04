require 'rails_helper'

RSpec.describe "users/index", type: :view do
  before(:each) do
    assign(:users, [
      User.create!(
        :principal => "Principal"
      ),
      User.create!(
        :principal => "Principal"
      )
    ])
  end

  it "renders a list of users" do
    render
    assert_select "tr>td", :text => "Principal".to_s, :count => 2
  end
end
