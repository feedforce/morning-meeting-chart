require 'rails_helper'

RSpec.describe "infos/new", type: :view do
  before(:each) do
    assign(:info, Info.new(
      :title => "MyString",
      :owner => "MyString"
    ))
  end

  it "renders new info form" do
    render

    assert_select "form[action=?][method=?]", infos_path, "post" do

      assert_select "input#info_title[name=?]", "info[title]"

      assert_select "input#info_owner[name=?]", "info[owner]"
    end
  end
end
