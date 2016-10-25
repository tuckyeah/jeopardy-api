# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'csv'

# REFACTOR THIS FURTHER we can make this better.
# returns an array with each row of the file converted to a hash
def convert_to_hash
  arr = []
  CSV.foreach('lib/seeds/small_jeopardy.csv',
              headers: true,
              header_converters: -> (h) { h.lstrip.downcase.to_sym }) do |row|
                arr << row.to_h
              end
  arr.reject! { |h| h[:question].include? '<a href=' }
  arr.reject! { |h| h[:answer].include? '<a href=' }
  arr.each { |h| h[:value] = h[:value].rstrip.delete(',').slice(/\d+/).to_i }
  arr
end

data = convert_to_hash

# get all the clues associated with that category
category_hash = data.group_by { |h| h[:category] }
category_hash.reject! { |k, _v| category_hash[k].length < 5 }

# get all clues associated with that value
value_hash = data.group_by { |h| h[:value] }
value_hash.reject! { |k, _v| value_hash[k].length < 5 }

res = category_hash.merge(value_hash)
res.reject! { |k, _v| res[k].length < 5 }
res.reject! { |k, _v| k.is_a? Fixnum }

def convert_val_to_num(num)
  num.rstrip.delete(',').slice(/\d+/).to_i
end

res.each_key do |category|
  @category = Category.create([{ name: category }])
  clues = res[category]
  clue_group = clues.group_by { |clue| clue[:value] }
  clue_group.each_key do |key|
    sample = clue_group[key].sample(1).first
    Clue.create([{ question: sample[:question], answer: sample[:answer],
                   value: sample[:value], category_id: @category[0][:id] }])
  end
end
