namespace :db do
	desc "Fill database with sample data"
	task populate: :environment do #environment makes sure the task has access to the full rails environment and user models
		#the "!" throws an exception for debugging purposes in case of a wrong user creation, rather than just false
		make_users
		make_microposts
		make_relationships
	end
end

def make_users
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

def make_microposts 

	users = User.all(limit:6)
	50.times do
		content = Faker::Lorem.sentence(5)
		users.each { |user| user.microposts.create!(content: content) }	
	end
end

def make_relationships
	users = User.all
	user = users.first
	followed_users = users[2..50]
	followers      = users[3..40]
	followed_users.each { |followed| user.follow!(followed) }
	followers.each      { |follower| follower.follow!(user) }
end