# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
	factory :rating do
		association :ratable, factory: :interest_point
		user
		score { Random.rand(6) }
	end
end
