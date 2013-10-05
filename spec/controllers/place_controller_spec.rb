require 'spec_helper'

describe PlaceController do

  describe "GET 'Relationships'" do
    it "returns http success" do
      get 'Relationships'
      response.should be_success
    end
  end

end
