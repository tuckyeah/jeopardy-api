class Logic < ActiveRecord::Base
  @@STOP_WORDS = ['AND', 'THE', 'OR'] # words to ignore when we're parsing an answer

  def remove_parens(answer)
    answer.scan(/\((\w+)\)\s*(\w*)/).flatten
  end

  def include_parens?(answer)
    answer.scan(/\((\w+)\)\s*(\w*)/).empty?
  end

  def validate_answer(answer, response)
    answer = remove_parens(answer) if include_parens(answer)
    return true if answer.casecmp == response.casecmp

    answer.casecmp.include?(response.casecmp)
  end

  def increment_score
  end
end
