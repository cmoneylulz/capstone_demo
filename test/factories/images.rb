# Factory for testing Image objects

FactoryGirl.define do
	factory :image do
		file { File.open("#{Rails.root}/test/support/bremen.jpg") }
		association :interest_point, factory: :interest_point
		association :contributor, factory: :user
	end
end