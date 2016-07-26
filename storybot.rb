
$LOAD_PATH.unshift "lib"

require 'wordnet'
require 'pp'
require_relative 'functions'

$lex = WordNet::Lexicon.new
$print_synsets = false
$print_noun_samples = false
$print_verb_samples = false
$print_adjective_samples = false
$print_nouns = false
$print_verbs = false
$print_adjectives = false



puts "Hello! I'm Storybot.\n To end the conversation enter \'cya\'.\n For help enter '\\help'.\n What would you like to complain about today?\n\n>>"
user_response = gets.chomp

while not user_response.include? "cya" do
	puts

	if is_command?(user_response)
		handle_commands(user_response)
	else
		topic_sentence = user_response
		puts "Let me tell you a story.......\n\n"

		while true do
			story = get_story(topic_sentence)
			puts story
			puts 'Would you like me to continue? [y/n]'
			
			if gets.chomp.include? 'n' then break end

			topic_sentence = story[story.length / 2, story.length - 1].join(' ')
		end
	end

	print "\n>> "

	user_response = gets.chomp
end

puts 'BYE!'