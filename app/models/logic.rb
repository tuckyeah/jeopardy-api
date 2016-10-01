module Logic
  def remove_parens(answer)
    answer.scan(/\((\w+)\)\s*(\w*)/).flatten
  end

  def include_parens?(answer)
    answer.scan(/\((\w+)\)\s*(\w*)/).empty?
  end

  def evaluate_answer(answer, response)
    answer.gsub(/[',]/, '').upcase!
    answer = remove_parens(answer) unless include_parens?(answer)

    puts "answer is: #{answer}"
    puts "response is: #{response}"
    answer.include?(response.upcase)
  end

  # def increment_score
  # end

  def test
    puts 'I ran'
  end
end
