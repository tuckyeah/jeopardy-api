module Logic
  def remove_parens(answer)
    answer.scan(/\((\w+)\)\s*(\w*)/).flatten.join(' ')
  end

  def include_parens?(answer)
    answer.scan(/\((\w+)\)\s*(\w*)/).empty?
  end

  def parse(answer)
    # strips both correct answer and user response of commas and
    # apostrophes, as well as any 'filler words', and downcases them both
    answer.gsub(/[',]/, '').gsub(/^(the|a|an) /i, '').strip.downcase
  end

  def evaluate_answer(correct, response)
    correct = parse(correct)
    response = parse(response)

    correct = remove_parens(correct) unless include_parens?(correct)
    # uses 'WhiteSimiliarity' gem to create a 'fuzzy' match to account
    # for typos
    fuzzy_match = WhiteSimilarity.similarity(correct, response)
    correct == response || fuzzy_match > 0.6
  end

  def test
    puts 'I ran'
  end
end
