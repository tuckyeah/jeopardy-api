# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'csv'

CSV.foreach('lib/seeds/small_jeopardy.csv',
              headers: true,
              header_converters: -> (h) { h.lstrip.downcase.to_sym } ) do |row|
                c = row.to_h
                Clue.create([{ question: c[:question], answer: c[:answer],
                               value: c[:value] }])
              end
