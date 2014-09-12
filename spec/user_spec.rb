# -*- encoding : utf-8 -*-
RSpec.describe Wanikani::User do
  describe ".information" do
    before(:each) do
      stub_request(:get, "http://www.wanikani.com/api/user/WANIKANI-API-KEY/user-information/").
         to_return(body: File.new("spec/fixtures/user-information.json"))
    end

    it "returns a hash with the Wanikani account information" do
      user_info = Wanikani::User.information
      expect(user_info).to be_a(Hash)

      expect(user_info["username"]).to eq("crabigator")
      expect(user_info["gravatar"]).to eq("gravatarkey")
      expect(user_info["level"]).to eq(25)
      expect(user_info["title"]).to eq("Turtles")
      expect(user_info["about"]).to eq("I am the almighty crabigator!")
      expect(user_info["website"]).to eq("http://www.wanikani.com/")
      expect(user_info["twitter"]).to eq("WaniKaniApp")
      expect(user_info["topics_count"]).to eq(1000)
      expect(user_info["posts_count"]).to eq(500)
      expect(user_info["creation_date"]).to eq(1337820000)
    end
  end

  describe ".on_vacation?" do
    it "returns false if the vacation_date field is null" do
      stub_request(:get, "http://www.wanikani.com/api/user/WANIKANI-API-KEY/user-information/").
         to_return(body: File.new("spec/fixtures/user-information.json"))

      expect(Wanikani::User.on_vacation?).to be_falsey
    end

    it "returns true if the vacation_date field is not null" do
      stub_request(:get, "http://www.wanikani.com/api/user/WANIKANI-API-KEY/user-information/").
         to_return(body: File.new("spec/fixtures/user-on-vacation.json"))

      expect(Wanikani::User.on_vacation?).to be_truthy
    end
  end

  describe ".gravatar_url" do
    before(:each) do
      stub_request(:get, "http://www.wanikani.com/api/user/WANIKANI-API-KEY/user-information/").
         to_return(body: File.new("spec/fixtures/user-information.json"))
    end

    it "raises an ArgumentError if the size parameter is not an integer" do
      expect {
        Wanikani::User.gravatar_url(size: 123.45)
      }.to raise_error(ArgumentError)
    end

    it "returns nil if the Gravatar hash for the user is nil" do
      stub_request(:get, "http://www.wanikani.com/api/user/WANIKANI-API-KEY/user-information/").
         to_return(body: File.new("spec/fixtures/user-information-no-gravatar.json"))

      expect(Wanikani::User.gravatar_url).to be_nil
    end

    it "returns the secure Gravatar URL using the Gravatar hash for the user if the :secure option is set" do
      gravatar_url = Wanikani::User.gravatar_url(secure: true)
      expect(gravatar_url).to match(/https:\/\/secure\.gravatar\.com/)
      expect(gravatar_url).to match(/gravatarkey/)
    end

    it "returns the non-secure Gratavar URL using the Gravatar hash for the user if the :secure option is not set" do
      gravatar_url = Wanikani::User.gravatar_url
      expect(gravatar_url).to match(/http:\/\/www\.gravatar\.com/)
      expect(gravatar_url).to match(/gravatarkey/)
    end

    it "sets the 'mm' URL parameter for a default image" do
      gravatar_url = Wanikani::User.gravatar_url
      expect(gravatar_url).to match(/d=mm/)
    end

    it "sets the 'size' URL parameter if specified" do
      gravatar_url = Wanikani::User.gravatar_url(size: 250)
      expect(gravatar_url).to match(/size=250/)
    end
  end
end
