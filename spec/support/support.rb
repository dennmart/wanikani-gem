module Wanikani::Support
  def headers
    {
      'Accept'=>'*/*',
      'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
      'Authorization'=>'Bearer my-api-key',
      'Content-Type'=>'application/json',
      'User-Agent'=>'Faraday v0.17.3',
      'Wanikani-Revision'=>'20170710'
    }
  end
end
