# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Wanikani::User do
  describe ".information" do
    before(:each) do
      FakeWeb.register_uri(:get,
                           "http://www.wanikani.com/api/user/WANIKANI-API-KEY/user-information/",
                           :body => "spec/fixtures/user-information.json")
    end

    it "returns a hash with the Wanikani account information" do
      user_info = Wanikani::User.information
      user_info.should be_a(Hash)

      user_info["username"].should == "crabigator"
      user_info["gravatar"].should == "gravatarkey"
      user_info["level"].should == 25
      user_info["title"].should == "Turtles"
      user_info["about"].should == "I am the almighty crabigator!"
      user_info["website"].should == "http://www.wanikani.com/"
      user_info["twitter"].should == "WaniKaniApp"
      user_info["topics_count"].should == 1000
      user_info["posts_count"].should == 500
      user_info["creation_date"].should == 1337820000
    end
  end
end
