require "test_helper"

describe ApplicationHelper do
  describe "#active_link_to" do
    it "returns link with class 'active' when url match" do
      stub(controller.request).path_info { "/" }
      active_link_to("Home", "/").must_equal '<a href="/" class="active">Home</a>'
    end

    it "returns link without class 'active' when url does not match" do
      stub(controller.request).path_info { "/bad" }
      active_link_to("Home", "/").must_equal '<a href="/">Home</a>'
    end
  end
end
