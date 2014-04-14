# Factory for testing Category objects

FactoryGirl.define do
	factory :category do
		sequence(:name) { |n| "#{Faker::Company.bs}#{n}" }

		factory :category_with_comments do
			ignore do
				number_of_comments 3
			end
			after :create do |category, evaluator|
				FactoryGirl.create_list :comment, evaluator.number_of_comments, category: category
			end
		end
	end
end