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

  describe ".on_vacation?" do
    it "returns false if the vacation_date field is null" do
      FakeWeb.register_uri(:get,
                           "http://www.wanikani.com/api/user/WANIKANI-API-KEY/user-information/",
                           :body => "spec/fixtures/user-information.json")

      Wanikani::User.on_vacation?.should be_false
    end

    it "returns true if the vacation_date field is not null" do
      FakeWeb.register_uri(:get,
                           "http://www.wanikani.com/api/user/WANIKANI-API-KEY/user-information/",
                           :body => "spec/fixtures/user-on-vacation.json")

      Wanikani::User.on_vacation?.should be_true
    end
  end

  describe ".gravatar_url" do
    before(:each) do
      FakeWeb.register_uri(:get,
                           "http://www.wanikani.com/api/user/WANIKANI-API-KEY/user-information/",
                           :body => "spec/fixtures/user-information.json")
    end

    it "raises an ArgumentError if the size parameter is not an integer" do
      expect {
        Wanikani::User.gravatar_url(size: 123.45)
      }.to raise_error(ArgumentError)
    end

    it "returns nil if the Gravatar hash for the user is nil" do
      FakeWeb.register_uri(:get,
                           "http://www.wanikani.com/api/user/WANIKANI-API-KEY/user-information/",
                           :body => "spec/fixtures/user-information-no-gravatar.json")

      Wanikani::User.gravatar_url.should be_nil
    end

    it "returns the secure Gravatar URL using the Gravatar hash for the user if the :secure option is set" do
      gravatar_url = Wanikani::User.gravatar_url(secure: true)
      gravatar_url.should match /https:\/\/secure\.gravatar\.com/
      gravatar_url.should match /gravatarkey/
    end

    it "returns the non-secure Gratavar URL using the Gravatar hash for the user if the :secure option is not set" do
      gravatar_url = Wanikani::User.gravatar_url
      gravatar_url.should match /http:\/\/www\.gravatar\.com/
      gravatar_url.should match /gravatarkey/
    end

    it "sets the 'mm' URL parameter for a default image" do
      gravatar_url = Wanikani::User.gravatar_url
      gravatar_url.should match /d=mm/
    end

    it "sets the 'size' URL parameter if specified" do
      gravatar_url = Wanikani::User.gravatar_url(size: 250)
      gravatar_url.should match /size=250/
    end
  end
end
