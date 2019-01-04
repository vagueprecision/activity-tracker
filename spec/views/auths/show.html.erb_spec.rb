require 'rails_helper'

RSpec.describe "auths/show", type: :view do
  before(:each) do
    @auth = assign(:auth, Auth.create!(
      :name => "Name",
      :principal => "Principal"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Principal/)
  end
end
