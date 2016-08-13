require 'rails_helper'

RSpec.describe "shared_infos/new", type: :view do
  before(:each) do
    assign(:shared_info, SharedInfo.new(
      :title => "MyString",
      :owner => "MyString",
      :body => "MyString"
    ))
  end

  it "renders new shared_info form" do
    render

    assert_select "form[action=?][method=?]", shared_infos_path, "post" do

      assert_select "input#shared_info_title[name=?]", "shared_info[title]"

      assert_select "input#shared_info_owner[name=?]", "shared_info[owner]"

      assert_select "input#shared_info_body[name=?]", "shared_info[body]"
    end
  end
end
