class TopicSentence 
	def initialize(text)
		@text = text

		begin
			@parsed = $dictionary.parse(text)
		rescue => e
			puts 'Linkage Error: That sentence has no linkages, try a different sentence'
		end
	end

	def subject
		@parsed.subject
	end

	def verb
		@parsed.verb
	end

	def object
		@parsed.object
	end
end