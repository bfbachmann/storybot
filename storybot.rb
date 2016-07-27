
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

$mode = :chunks
$talk = false


puts "Hello! I'm Storybot.
To end the conversation enter \'cya\'.
For help enter '\\help'.
To end a story enter 'end'. 
What would you like to complain about today?\n\n>>"

user_response = gets.chomp

while not user_response.include? "cya" do
	puts

	if is_command?(user_response)
		handle_commands(user_response)
	elsif $mode == :chunks
		tell_in_chunks(user_response)
	else
		tell_in_sentences(user_response)
	end

	print "\n>> "

	user_response = gets.chomp
end

puts 'BYE!'