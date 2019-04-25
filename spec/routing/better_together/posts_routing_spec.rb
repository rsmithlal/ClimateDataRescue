require "rails_helper"

RSpec.describe BetterTogether::PostsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/better_together/posts").to route_to("better_together/posts#index")
    end

    it "routes to #new" do
      expect(:get => "/better_together/posts/new").to route_to("better_together/posts#new")
    end

    it "routes to #show" do
      expect(:get => "/better_together/posts/1").to route_to("better_together/posts#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/better_together/posts/1/edit").to route_to("better_together/posts#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/better_together/posts").to route_to("better_together/posts#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/better_together/posts/1").to route_to("better_together/posts#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/better_together/posts/1").to route_to("better_together/posts#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/better_together/posts/1").to route_to("better_together/posts#destroy", :id => "1")
    end
  end
end
