require './app'

# rubocop:disable Metrics/CyclomaticComplexity, Metrics/MethodLength
def main
  app = App.new
  books, people, rentals = nil

  begin
    books = File.open("books.json")
    people = File.open("people.json")
    rentals = File.open("rentals.json")
  rescue => exception
    # print what error the system is gaving us
  else
    app.from_json(books: books, people: people, rentals: rentals)
  end
  
  

  response = nil
  print 'Welcome to School Library App!'
  while response != 7
    puts 'Please choose an options by entering a number'
    puts '1 - List all books'
    puts '2 - List all people'
    puts '3 - Create a person'
    puts '4 - Create a book'
    puts '5 - Create a rental'
    puts '6 - List all rentals for a given person id'
    puts '7 - Exit'
    response = gets.chomp.to_i
    case response
    when 1
      app.all_books
    when 2
      app.all_people
    when 3
      app.create_person
    when 4
      app.create_book
    when 5
      app.create_rental
    when 6
      app.all_rentals
    when 7
      puts 'Thank you for using this app'
    end
    puts "\n"
  end
end

# rubocop:enable Metrics/CyclomaticComplexity, Metrics/MethodLength
main
