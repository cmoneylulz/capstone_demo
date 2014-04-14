# Factory for testing Role objects

FactoryGirl.define do
	factory :role do
		name "Administrator"

		factory :contributor do
			name "Contributor"
		end

		factory :guest do
			name "Guest"
		end
	end
end