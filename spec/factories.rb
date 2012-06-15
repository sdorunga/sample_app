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

	factory :micropost do
		content "Lorem ipsum"
		user #automatically associates the content with the user; allows for FactoryGirl.create(:micropost, user: @user, created_at: 1.day.ago)
	end
end
