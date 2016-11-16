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

data = convert_to_hash # get an array of hashes from csv

values_a = [100,200,300,400,500]
values_b = [200,400,600,800,1000]
values_c = [400, 800, 1200, 1600, 2000]
all_vals = [values_a, values_b, values_c]

# get all the clues associated with that category, and make sure there are at least 5
category_hash = data.group_by { |h| h[:category] }
category_hash.reject! { |k, _v| category_hash[k].length < 5 }

# get all clues associated with that value, and make sure there are at least 5
value_hash = data.group_by { |h| h[:value] }
value_hash.reject! { |k, _v| value_hash[k].length < 5 }

# merge them and get a hash of categories, then values
res = category_hash.merge(value_hash)
res.reject! { |k, _v| res[k].length < 5 }
res.reject! { |k, _v| k.is_a? Fixnum }

res.each_key do |category|
  val_index = nil
  clue_vals = res[category].group_by{|clue| clue[:value] } # group that category's clues by their values
  if all_vals.include?(clue_vals.keys) # see if the all values array includes which values those clues are
    val_index = all_vals.find_index(clue_vals.keys)
  end
  category_maker(category, clue_vals, val_index, all_vals)
  break if CategoryBuilder.all_instances.length == 10
end

class CategoryBuilder
  attr_accessor :clues, :counter, :name
  @@counter = []
  @@names = []

  def initialize(category)
    @name = category
    @clues = []
    @@counter << self
    @@names << name
  end

  def add_clue(clue)
    @clues << clue
  end

  def self.all_instances
    @@counter
  end

  def self.all_names
    @@names
  end
end

category_counter = []

def category_maker(category, clue_vals, val_index, all_vals)
  return if val_index.nil?

  category = CategoryBuilder.new(category) # replace this with actual category builder and test
  all_vals[val_index].each do |num|
    sample = clue_vals[num].sample
    category.clues << sample # add another test to make sure that the length is at least five or something, or that they're unique
  end

  puts "Category is: #{category.name}"
  puts "Clues are: #{category.clues.length}"
end




# then, as long as val_index is not nil
# use that category to make a new category
# and iterate through the corresponding values array, picking one clue from each value
# and adding it to the category


res.each_key do |category|
  @category = Category.create([{ name: category }])
  clues = res[category]
  clue_group = clues.group_by { |clue| clue[:value] }
  clue_group.each_key do | key |
    sample = clue_group[key].sample(1).first
    Clue.create([{ question: sample[:question], answer: sample[:answer],
                   value: sample[:value], category_id: @category[0][:id] }])
  end
end

# categoryBuilder
# sort of a 'fake' category builder before we build them in rails
# it will:
#     try to create make its own category class
#     make sure that there it has five clues of unique, ascending values
#     if that works, it will actually make the category and clues
