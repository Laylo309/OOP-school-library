require_relative './rental'
require 'json'

class Book
  attr_accessor :title, :author, :rentals

  def initialize(title, author)
    @title = title
    @author = author
    @rentals = []
  end

  def add_rental(date, person)
    Rental.new(date, person, self)
  end

  def to_json
    JSON.dump ({
      title: @title,
      author: @author,
      # rentals: @rentals,
    })
  end
end
