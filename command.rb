class Command
	attr_reader :help,:command,:regex,:usage
	def initialize(command,regex,help,usage)
		@regex = regex
		@help = help
		@usage = usage
	end

	def help()
		@help
	end

	def to_s()
		@usage
	end
end
