require "test_helper"

# Tests to ensure validity of a +Rating+ object
# @author Ashley Childress
# @version 3.16.2014
describe Rating do

  before do
    @rating = Rating.new
  end

	it "is valid with valid params" do
		FactoryGirl.build(:rating).must_be :valid?
  end

  describe "is not valid when" do

		it "has no ratable object" do
			FactoryGirl.build(:rating, ratable: nil).wont_be :valid?
		end

	  it "has no user" do
			FactoryGirl.build(:rating, user: nil).wont_be :valid?
	  end
  end

	it "calculates average rating" do
		skip "investigate failure"
		ip = FactoryGirl.create(:interest_point)
		u = FactoryGirl.create(:user)
		ratings = [Rating.create!(ratable: ip, user: u, score: 1),
		           Rating.create!(ratable: ip, user: u, score: 2),
		           Rating.create!(ratable: ip, user: u, score: 3),
		           Rating.create!(ratable: ip, user: u, score: 4),
		           Rating.create!(ratable: ip, user: u, score: 5)]
		Rating.average_rating(ratings[0]).must_equal 3.0
		Rating.average_rating(ratings[3]).must_equal 3.0
		Rating.average_rating(ratings[4]).must_equal 3.0
	end
end