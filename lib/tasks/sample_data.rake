namespace :db do
	desc "Fill database with sample data"
	task populate: :environment do #environment makes sure the task has access to the full rails environment and user models
		#the "!" throws an exception for debugging purposes in case of a wrong user creation, rather than just false
		admin = User.create!(name: "Example User", email: "example@railstutorial.org", password: "foobar", password_confirmation: "foobar")
		admin.toggle!(:admin) #the adim attribute is not in the initialization hash ^ because it is not attr_accessible, which is for security reasons, as those can be change through PUT this cannot
		

		99.times do |n|
			name = Faker::Name.name
			email = "example-#{n+1}@railstutorial.org"
			password = "password"
			User.create!(name: name,
					  email: email,
					  password: password,
					  password_confirmation: password
			         ) 
		end
	end
end