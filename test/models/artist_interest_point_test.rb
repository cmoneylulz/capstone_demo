require "test_helper"

describe ArtistInterestPoint do
  before do
    @artist_interest_point = ArtistInterestPoint.new
  end

  it "must be valid" do
    @artist_interest_point.valid?.must_equal true
  end
end
