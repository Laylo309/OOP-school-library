require 'json'

class Rental
  attr_accessor :date
  attr_reader :person, :book

  def initialize(date, person, book)
    @date = date

    @person = person

    @book = book
    
    person.rentals << self 
    book.rentals << self
  end

  def to_json
    JSON.dump ({
      date: @date,
      person: @person.to_json,
      book: @book.to_json
    })
  end
end
