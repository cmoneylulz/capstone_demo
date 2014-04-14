# Factory for testing User objects

FactoryGirl.define do
	factory :user do
		first_name { Faker::Name.first_name }
		last_name { Faker::Name.last_name }
		sequence(:user_name) { |n| "#{first_name}#{last_name}_#{n}".gsub(/[^a-zA-Z ]/,'') }
		email { "#{user_name}@email.com" }
		password "Password1"
		password_confirmation "Password1"
		association :role, factory: :role

		factory :user_from_social_media do
			password ""
			password_confirmation ""
			provider { Faker::Company.name }
			uid { Faker::Number.number(9) }
		end
	end
end