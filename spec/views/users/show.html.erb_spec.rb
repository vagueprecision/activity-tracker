require 'rails_helper'

RSpec.describe "users/show", type: :view do
  before(:each) do
    @user = assign(:user, User.create!(
      :principal => "Principal"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Principal/)
  end
end
