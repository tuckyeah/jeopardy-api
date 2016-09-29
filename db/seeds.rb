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
  arr
end


def create_categories(data)
  data.each do |hsh|
    categories = Category.all
    unless categories.where(name: hsh[:category]).length == 1
      Category.create([{ name: hsh[:category] }])
    end
  end
end

def convert_val_to_num(num)
  num.slice(/\d+/).to_i
end

def populate_categories(data)
  data.each do |hsh|
    category_id = Category.where(name: hsh[:category]).ids[0]
    unless hsh[:question].include? '<a href=' or hsh[:answer].include? '<a href='
      hsh[:value] = convert_val_to_num(hsh[:value].rstrip)
      Clue.create([{ question: hsh[:question], answer: hsh[:answer],
                     value: hsh[:value], category_id: category_id }])
    end
  end
end


data = convert_to_hash
create_categories(data)
populate_categories(data)
