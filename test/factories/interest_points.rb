# Factory for testing Interest Point objects

FactoryGirl.define do
	factory :interest_point do
		sequence(:name) { |n| "#{Faker::Company.name}#{n}" }
		summary { Faker::Lorem.paragraphs(3).join("\n") }
		latitude { 33.5801100 }
		longitude { -85.0766100 }
		association :category, factory: :category
		association :contributor, factory: :user

		factory :interest_point_approved do
			association :approver, factory: :user
			approved_at DateTime.now
		end
	end

end
