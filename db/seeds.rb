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
category_hash = data.group_by{ |h| h[:category] }
category_hash.reject! { |k, _v| category_hash[k].length < 5}

# get all clues associated with that value
value_hash = data.group_by { |h| h[:value] } # use this to get a random clue from each key!
value_hash.reject! { |k, _v| value_hash[k].length < 5}

res = category_hash.merge(value_hash)

res.reject! { |k, _v| res[k].length < 5 } # reject anything that doesn't have at least 5 clues
res.reject! { |k, _v| k.is_a? Fixnum } # make sure we don't have any values as keys

def convert_val_to_num(num)
  num.rstrip.delete(',').slice(/\d+/).to_i
end

# i'm going to have to change this when we scale to a larger file

# res.each_key do | key |
#   categories = Category.all
#     unless categories.where(name: key).length == 1
#       Category.create([{ name: key }])
#     end
# end

# def make_categories(key)
#   categories = Category.all
#     unless categories.where(name: key).length == 1
#       Category.create([{ name: key }])
#     end
# end
#
# test_arr = []

category_hash.each_key do |cat_key|
  @category = Category.create([{ name: cat_key }])
  value_hash.each_key do |val_key|
    res = value_hash[val_key].sample(1).first
    Clue.create([{ question: res[:question], answer: res[:answer],
                  value: res[:value], category_id: @category[0][:id]}])
  end
end


# make clues function that will go through every category, and for every category
# every key in the values hash
# and pick one clue from that hash that matches the current category name

# category.each do |cat|
#   value_hash.keys do |value key|
#     value_hash[val_key].select where clue:category = category.name
#     create that clue


# res.each_pair do |key, clue_array|
#   make_categories(key)
#   clue_array.each do |clue|
#     category_id = Category.where(name: key).ids[0]
#     clue[:value] = clue[:value].to_i
#     Clue.create([{ question: clue[:question], answer: clue[:answer],
#                    value: clue[:value], category_id: category_id }])
#   end
# end
