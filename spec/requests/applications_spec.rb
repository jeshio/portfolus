require 'rails_helper'

RSpec.describe "Applications", :type => :request do
  describe "GET Root Page" do
    it "works! (now write some real specs)" do
      get root_path
      assert_response :success
    end
  end
end
