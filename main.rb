require './person'
require './book'
require './classroom'
require './rental'
require './student'
require './teacher'

class App
  def initialize
    @books = []
    @people = []
    @rentals = []
  end

  def all_books
    @books.each do |book|
      puts "Title: #{book.title} , Author: #{book.author}"
    end
  end

  def all_people
    @people.each do |person|
      puts "[#{person.class}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
    end
  end

  def create_person
    puts 'Do you want to create a student (1) or a teacher (2)? [Input the number]: '
    person_type = gets.chomp

    if person_type != '1' && person_type != '2'
      puts 'Invalid option'
      nil
    end

    print 'Age:'
    age = gets.chomp

    print 'Name:'
    name = gets.chomp

    person =
      case person_type
      when '1'
        print 'Has parent permission? [Y/N]: '
        parent_permission = gets.chomp
        parent_permission = parent_permission.downcase == 'y'

        Student.new(age, name, parent_permission)
      when '2'
        print 'Specialization:'
        specialization = gets.chomp

        Teacher.new(age, specialization, name)
      end

    @people << person
    puts 'Person created'
  end

  # *Create a book.
  def create_book
    print 'Title: '

    title = gets.chomp

    print 'Author: '

    author = gets.chomp

    @books << Book.new(title, author)
    puts 'Book created'
  end

  def create_rental
    print 'Select a book from the following list by number'
    @book.each_with_index do |book, index|
      puts "#{index} Title: #{book.title}, Author: #{book.author}"
    end

    book_rental = gets.chomp.to_i

    print "\nSelect a person from th following list by number (not id)"
    @people.each_with_index do |person, index|
      puts "#{index} #{person.class} Name: #{person.name}, Id: #{person.id}, Age: #{person.age}"
    end

    person_rental = gets.chomp.to_i

    print "\nDate"

    date = gets.chomp
    @rentals << Rental.new(date, @people[person_rental], @books[book_rental])
    print 'Rental created successfully'
  end

  def all_rentals
    print 'Id of the person:'

    id = gets.chomp
    rentals = @rentals.filter { |rental| rental.person.id == id }
    puts 'Rentals:'
    rentals.each do |rental|
      puts "Date: #{rental.date}, Book #{rental.book.title} by #{rental.book.author}"
    end
  end
end

def main
  app = App.new

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
    response = gets.chomp
    case response
    when '1'
      app.all_books
    when '2'
      app.all_people
    when '3'
      app.create_person
    when '4'
      app.create_book
    when '5'
      app.create_rental
    when '6'
      app.all_rentals
    when '7'
      puts 'Thank you for using this app'
    end
    puts "\n"
  end
end

main()
