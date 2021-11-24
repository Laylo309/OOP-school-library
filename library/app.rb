require_relative './person'
require_relative './book'
require_relative './classroom'
require_relative './rental'
require_relative './student'
require_relative './teacher'
require_relative './storage'
require 'json'

class App
  include Storage
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

  # rubocop:disable Metrics/MethodLength

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

  # rubocop:enable Metrics/MethodLength

  def create_book
    print 'Title: '

    title = gets.chomp

    print 'Author: '

    author = gets.chomp

    @books << Book.new(title, author)
    puts 'Book created'
  end

  def create_rental
    puts 'Select a book from the following list by number\n'
    @books.each_with_index do |book, index|
      puts "#{index}) Title: #{book.title}, Author: #{book.author}"
    end

    book_rental = gets.chomp.to_i

    print "\nSelect a person from th following list by number (not id)\n"
    @people.each_with_index do |person, index|
      puts "#{index}) [#{person.class}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
    end

    person_rental = gets.chomp.to_i

    print "\nDate "

    date = gets.chomp

    @rentals << Rental.new(date, @people[person_rental], @books[book_rental])
    print 'Rental created successfully'
  end

  def all_rentals
    print 'ID of the person:'

    id = gets.chomp.to_i
    rentals = @rentals.filter { |rental| rental.person.id == id }
    puts 'Rentals:'
    rentals.each do |rental|
      puts "Date: #{rental.date}, Book #{rental.book.title} by #{rental.book.author}"
    end
  end

  def save_state
    rental_to_json
    book_to_json
    people_to_json

    puts 'State saved successfully'
  end

  def load_state
      if File.exist?('books.json')
        books = File.read 'books.json'
        from_json(books: books)
      end
  
      if File.exist?('people.json')
        people = File.read 'people.json'
        from_json(people: people)
      end
  
      if File.exist?('books.json') && File.exist?('people.json') && File.exist?('rentals.json')
        rentals = File.read 'rentals.json'
  
        from_json(rentals: rentals)
      end
  end
end
