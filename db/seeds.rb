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
  arr.reject!{|h| h[:question].include? "<a href=" }
  arr.reject!{|h| h[:answer].include? "<a href=" }
  arr.each {|h| h[:value] = h[:value].rstrip.delete(',').slice(/\d+/).to_i }
  arr
end

data = convert_to_hash

# get all the clues associated with that category
category_hash = data.group_by{|h| h[:category] }

#get all clues associated with that value
value_hash = data.group_by {|h| h[:value] }

res = category_hash.merge(value_hash)

res.reject! { |k, _v| res[k].length < 5 }
res.reject! { |k, _v| k.is_a? Fixnum }

def convert_val_to_num(num)
  num.rstrip.delete(',').slice(/\d+/).to_i
end

# i'm going to have to change this when we scale to a larger file

res.each_key do | key |
  categories = Category.all
    unless categories.where(name: key).length == 1
      Category.create([{ name: key }])
    end
end

def make_categories(key)
  categories = Category.all
    unless categories.where(name: key).length == 1
      Category.create([{ name: key }])
    end
end

res.each_pair do |key, clue_array|
  make_categories(key)
  clue_array.each do |clue|
    category_id = Category.where(name: key).ids[0]
    clue[:value] = clue[:value].to_i
    Clue.create([{ question: clue[:question], answer: clue[:answer],
                   value: clue[:value], category_id: category_id}])
  end
end
