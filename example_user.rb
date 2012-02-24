class User
	attr_accessor :name, :email

	def initialize (attributes = {})
		@name = attributes[:name]
		@name = attributes[:email]
	end

	def formatted_mail
		"#{@name} <#{@email}>"		
	end
end