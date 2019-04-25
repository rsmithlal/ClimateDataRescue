require 'rails_helper'

RSpec.describe "better_together/posts/new", type: :view do
  before(:each) do
    assign(:better_together_post, BetterTogether::Post.new(
      :bt_id => "MyString"
    ))
  end

  it "renders new better_together_post form" do
    render

    assert_select "form[action=?][method=?]", better_together_posts_path, "post" do

      assert_select "input[name=?]", "better_together_post[bt_id]"
    end
  end
end
