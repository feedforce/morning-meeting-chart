require 'rails_helper'

RSpec.describe "infos/index", type: :view do
  before(:each) do
    assign(:infos, [
      Info.create!(
        :title => "Title",
        :owner => "Owner"
      ),
      Info.create!(
        :title => "Title",
        :owner => "Owner"
      )
    ])
  end

  it "renders a list of infos" do
    render
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "Owner".to_s, :count => 2
  end
end
