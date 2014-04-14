# Factory for testing Comment objects

FactoryGirl.define do
	factory :comment do
		author { Faker::Name.name }
		body { Faker::Lorem.sentences(3).join(" ") }
		association :commentable, factory: :interest_point
	end
end