require 'rails_helper'

RSpec.describe "shared_infos/edit", type: :view do
  before(:each) do
    @shared_info = assign(:shared_info, SharedInfo.create!(
      :title => "MyString",
      :owner => "MyString",
      :body => "MyString"
    ))
  end

  it "renders the edit shared_info form" do
    render

    assert_select "form[action=?][method=?]", shared_info_path(@shared_info), "post" do

      assert_select "input#shared_info_title[name=?]", "shared_info[title]"

      assert_select "input#shared_info_owner[name=?]", "shared_info[owner]"

      assert_select "input#shared_info_body[name=?]", "shared_info[body]"
    end
  end
end
