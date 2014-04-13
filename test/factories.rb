require 'faker'

# Defines a list of attributes for each model that are needed in order for it to pass validation
# @author Ashley Childress
# @version 2.28.2014
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
	
	factory :comment do
		author { Faker::Name.name }
		body { Faker::Lorem.sentences(3).join(" ") }
		association :commentable, factory: :interest_point
	end

	factory :image do
		file { File.open("#{Rails.root}/test/support/bremen.jpg") }
		association :interest_point, factory: :interest_point
		association :contributor, factory: :user
	end

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

	factory :role do
		name "Administrator"
		
		factory :contributor do
			name "Contributor"
		end
		
		factory :guest do
			name "Guest"
		end
	end

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