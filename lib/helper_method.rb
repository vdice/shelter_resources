require('./lib/resource')
require('./lib/item')
require('./lib/shelter')

module HelperMethod
  define_method(:capitalize_multiple_words) do |phrase|
        phrase.split(" ").each{|word|word.capitalize!}.join(" ")
    end
end
