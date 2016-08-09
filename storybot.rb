
$LOAD_PATH.unshift "lib"

require 'wordnet'
require 'pp'
require 'linkparser'
require_relative 'functions'
require_relative 'linkparser_interface'

$lex = WordNet::Lexicon.new
$dictionary = LinkParser::Dictionary.new
$print_synsets = false
$print_noun_samples = false
$print_verb_samples = false
$print_adjective_samples = false
$print_nouns = false
$print_verbs = false
$print_adjectives = false

$mode = :chunks
$talk = false

user_input = ""

while not user_input.include? 'exit' do
	user_input = gets.chomp
	sentence = TopicSentence.new user_input
	puts sentence.subject
	puts sentence.verb
	puts sentence.object
end
# puts "Hello! I'm Storybot.
# To end the conversation enter \'cya\'.
# For help enter '\\help'.
# To end a story enter 'end'. 
# What would you like to complain about today?\n\n>>"

# user_response = gets.chomp

# while not user_response.include? "cya" do
# 	puts

# 	if is_command?(user_response)
# 		handle_commands(user_response)
# 	elsif $mode == :chunks
# 		tell_in_chunks(user_response)
# 	else
# 		tell_in_sentences(user_response)
# 	end

# 	print "\n>> "

# 	user_response = gets.chomp
# end

# puts 'BYE!'