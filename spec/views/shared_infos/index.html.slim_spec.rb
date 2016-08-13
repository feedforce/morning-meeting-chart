require 'rails_helper'

RSpec.describe "shared_infos/index", type: :view do
  before(:each) do
    assign(:shared_infos, [
      SharedInfo.create!(
        :title => "Title",
        :owner => "Owner",
        :body => "Body"
      ),
      SharedInfo.create!(
        :title => "Title",
        :owner => "Owner",
        :body => "Body"
      )
    ])
  end

  it "renders a list of shared_infos" do
    render
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "Owner".to_s, :count => 2
    assert_select "tr>td", :text => "Body".to_s, :count => 2
  end
end
