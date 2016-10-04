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
  CSV.foreach('lib/seeds/JEOPARDY_CSV.csv',
              headers: true,
              header_converters: -> (h) { h.lstrip.downcase.to_sym }) do |row|
                arr << row.to_h
              end
  arr.reject!{|h| h[:question].include? "<a href="}
  arr.reject!{|h| h[:answer].include? "<a href="}
  arr
end

data = convert_to_hash

@amounts = [100, 200, 400, 800, 1000, 1200, 1400, 1600, 1800, 2000]


# get all the clues associated with that category
category_hash = data.group_by{|h| h[:category]}

# select only categories that have more than 5 clues
category_hash = category_hash.select {|k, v| v.length >= 5 }

# category factory
def create_categories(data)
  categories = Category.all
  unless categories.where(name: data[:category]).length == 1
    Category.create([{ name: data[:category] }])
  end
end

def convert_val_to_num(num)
  num.rstrip.delete(',').slice(/\d+/).to_i
end

# clue factory
def create_clue(hsh)
  category_id = Category.where(name: hsh[:category]).ids[0]
  hsh[:value] = convert_val_to_num(hsh[:value]) if hsh[:value].is_a?(String)
  Clue.create([{ question: hsh[:question], answer: hsh[:answer],
                   value: hsh[:value], category_id: category_id }])
end

#pick a random number of categories

random_categories = category_hash.keys.sample(50)

random_categories.each do |key|
  categories = Category.all
  unless categories.where(name: key).length == 1
    Category.create([{ name: key }])
  end
end

random_categories.each do |cat|
  clue_list = category_hash[cat]
  clue_list.each { |clue| create_clue(clue) }
end

#
# def populate_categories(data)
#   data.each do |hsh|
#     create_clue(hsh)
#   end
# end
#
# def is_link?(hsh)
#   hsh[:question].include? '<a href=' or hsh[:answer].include? '<a href='
# end
#
# def create_clue(hsh)
#   category_id = Category.where(name: hsh[:category]).ids[0]
#   unless is_link?(hsh)
#     hsh[:value] = convert_val_to_num(hsh[:value]) if hsh[:value].is_a?(String)
#     Clue.create([{ question: hsh[:question], answer: hsh[:answer],
#                    value: hsh[:value], category_id: category_id }])
#   end
# end
#
# def limit_categories(data)
#   while Category.all.length <= 50 do
#     entry = data[rand(data.length + 1)]
#     create_categories(entry)
#   end
# end
#
# def limit_clues(data)
#   categories = Category.all
#   categories.each do |category|
#     @clues = data.find_all { |hsh| hsh[:category] == category.name }
#     populate_categories(@clues)
#   end
# end
#
# def filter_categories
#   @categories = Category.all
#   res = []
#   @categories.each do |category|
#     res << category if category.length < 6
#   end
# end
#
# data = convert_to_hash
# limit_categories(data)
# limit_clues(data)
# create_categories(data)
# populate_categories(data)
