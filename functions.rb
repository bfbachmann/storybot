require 'wordnet'
require 'pp'


def establish_context(sentence)
	nouns, noun_samples = get_words_by_pos(sentence, 'noun')
	verbs, verb_samples = get_words_by_pos(sentence, 'verb')
	adjectives, adjective_samples = get_words_by_pos(sentence, 'adjective')

	print_data(nouns, noun_samples, verbs, verb_samples, adjectives, adjective_samples)
	story = get_story(noun_samples, verb_samples, adjective_samples)

	puts story
	puts '...Want me to continue? [y/n]'

	if gets.chomp.include? 'y'
		establish_context(story.last(story.size / 2).join(''))
		puts '\n...Want me to continue? [y/n]'
	end

end


# Takes a sentence and returns a hash of all the words in the sentence
# that belong to the specified part of speech and sets them as the
# keys. A list of sample sentences for each noun are the
# corresponding values.
def get_words_by_pos(sentence, pos)
	words = sentence.downcase.strip.split(' ')
	nouns_in_sentence = {}
	samples = []

	words.each do |word|
		word_synsets = $lex.lookup_synsets(word)

		if $print_synsets
			puts "__SYNSETS__"
			PP.pp(word_synsets) 
			puts
		end

		word_synsets.each do |synset|
			if synset.part_of_speech == pos
				nouns_in_sentence[word] = synset.lexical_domain
				samples.push(synset.samples)
			end
		end
	end
	return nouns_in_sentence, samples
end


def is_command?(sentence)
	words = sentence.strip.split(' ')

	if words.first[0].to_s == '\\' then 
		return true 
	else 
		return false
	end 
end


def handle_commands(commands)
	if commands.include? '~synsets'
		$print_synsets = false
		puts 'print synsets OFF'
	elsif commands.include? 'synsets'
		$print_synsets = true
		puts 'print synsets ON'
	end

	if commands.include? '~samples'
		$print_noun_samples = $print_adjective_samples = $print_verb_samples = false
		puts 'print samples OFF'		
	elsif commands.include? 'samples'
		if commands.include? '-n'
			puts 'print nouns ON'
			$print_noun_samples = true
		end
		if commands.include? '-v'
			puts 'print verbs ON'
			$print_verb_samples = true
		end
		if commands.include? '-a'
			puts 'print adjectives ON'
			$print_adjective_samples = true;
		end
	end

	if commands.include? '~nouns'
		$print_nouns = false
		puts 'print nouns OFF'
	elsif commands.include? 'nouns'
		$print_nouns = true
		puts 'print nouns ON'
	end

	if commands.include? '~verbs'
		$print_verbs = false
		puts 'print verbs OFF'
	elsif commands.include? 'verbs'
		$print_verbs = true
		puts 'print verbs ON'
	end

	if commands.include? '~adjectives'
		$print_adjectives = false
		puts 'print adjectives OFF'
	elsif commands.include? 'adjectives'
		$print_adjectives = true
		puts 'print adjectives ON'
	end

	if commands.include? 'help'
		help = 
'SYNSETS:
	To print synonym sets for each word use "\synsets"
	To NOT print synonym sets for each word use "\~synsets"
				
SAMPLE SENTENCES:
	To print sample sentences for a part of speech use "\samples -[option]"
	To NOT print sample sentences for a part of speech use "\~samples"
		for nouns use "-n"
		for verbs use "-v"
		for adjectives use "-a"

PART OF SPEECH:
	To print the words recognised in the input with their part of speech use:
		"\\nouns" 
		"\\adjectives" 
		"\\verbs" 
	To NOT print the words recognised in the input with their part of speech use:
		"\\~nouns" 
		"\\~adjectives" 
		"\\~verbs" 

STATUS:
	To get the current output settings use "\status"'

		puts help
	end

	if commands.include? 'status'
		puts '$print_synsets:             ' + $print_synsets.to_s
		puts '$print_noun_samples:        ' + $print_noun_samples.to_s
		puts '$print_adjective_samples:   ' + $print_adjective_samples.to_s
		puts '$print_nouns:               ' + $print_nouns.to_s
		puts '$print_verbs:               ' + $print_verbs.to_s
		puts '$print_adjectives:          ' + $print_adjectives.to_s
	end
end


def print_data(nouns, noun_samples, verbs, verb_samples, adjectives, adjective_samples)
	if $print_nouns
		puts '__NOUNS__'
		PP.pp(nouns)
	end

	if $print_noun_samples
		puts '__NOUN SAMPLES__'
		PP.pp noun_samples
	end

	if $print_verbs
		puts '__VERBS__'
		PP.pp(verbs)
	end

	if $print_verb_samples
		puts '__VERB SAMPLES__'
		PP.pp verb_samples
	end

	if $print_adjectives
		puts '__ADJECTIVES__'
		PP.pp(adjectives)
	end

	if $print_adjective_samples
		puts 'ADJECTIVE SAMPLES__'
		PP.pp adjective_samples
	end
end


def get_story(noun_samples, verb_samples, adjective_samples)

	all_sentences = noun_samples + verb_samples + adjective_samples
	all_sentences.shuffle
	story = []

	all_sentences.each do |sentence|
		if not (sentence.nil? or sentence[0].nil?)
			words = sentence[0].split(' ')
			if words.include? 'he' or words.include? 'she' or words.include? 'i'	
				story.push(sentence)
			end
		end
	end

	return story
end