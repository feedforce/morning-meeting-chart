require 'rails_helper'

RSpec.describe "shared_infos/show", type: :view do
  before(:each) do
    @shared_info = assign(:shared_info, SharedInfo.create!(
      :title => "Title",
      :owner => "Owner",
      :body => "Body"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/Owner/)
    expect(rendered).to match(/Body/)
  end
end
