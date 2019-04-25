require 'rails_helper'

RSpec.describe "better_together/posts/edit", type: :view do
  before(:each) do
    @better_together_post = assign(:better_together_post, BetterTogether::Post.create!(
      :bt_id => "MyString"
    ))
  end

  it "renders the edit better_together_post form" do
    render

    assert_select "form[action=?][method=?]", better_together_post_path(@better_together_post), "post" do

      assert_select "input[name=?]", "better_together_post[bt_id]"
    end
  end
end
