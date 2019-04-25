require 'rails_helper'

RSpec.describe "better_together/posts/show", type: :view do
  before(:each) do
    @better_together_post = assign(:better_together_post, BetterTogether::Post.create!(
      :bt_id => "Bt"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Bt/)
  end
end
