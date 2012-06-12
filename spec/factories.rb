FactoryGirl.define do
	factory :user do
		sequence(:name) { |n| "Person #{n}" }
		sequence(:email) { |n| "person_#{n}@example.com" }
		password "foobar"
		password_confirmation "foobar"
	
		factory :admin do #allows to FactoryGirl.create(:admin) to create an admin user
			admin true
		end
	end
end