require "spec_helper"

describe SiliconsController do
  describe "routing" do

    it "routes to #index" do
      get("/silicons").should route_to("silicons#index")
    end

    it "routes to #new" do
      get("/silicons/new").should route_to("silicons#new")
    end

    it "routes to #show" do
      get("/silicons/1").should route_to("silicons#show", :id => "1")
    end

    it "routes to #edit" do
      get("/silicons/1/edit").should route_to("silicons#edit", :id => "1")
    end

    it "routes to #create" do
      post("/silicons").should route_to("silicons#create")
    end

    it "routes to #update" do
      put("/silicons/1").should route_to("silicons#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/silicons/1").should route_to("silicons#destroy", :id => "1")
    end

  end
end
