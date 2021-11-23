require './person'
require './book'
require './classroom'
require './rental'
require './student'
require './teacher'
require 'json'

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
    people_to_json
    puts 'Person created'
  end

  # rubocop:enable Metrics/MethodLength

  def create_book
    print 'Title: '

    title = gets.chomp

    print 'Author: '

    author = gets.chomp

    @books << Book.new(title, author)
    i = @books.length 
    book_to_json
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

    rental_to_json
    book_to_json
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

  def from_json(books: nil, people: nil, rentals: nil)
    if books
      from_books_json(books)
    end

    if people
      from_people_json(people)
    end

    if rentals
      from_rentals_json(rentals)
    end
  end

  private 

  def book_to_json
    book_json_array = []

    @books.each do |book|
      book_json_array.push(book.to_json)
    end

    book_json_array = JSON.dump ({
      books: book_json_array,
    })

    File.write("books.json", book_json_array)
  end

  def people_to_json
    people_json_array = []
    @people.each do |person|
      people_json_array.push(person.to_json)
    end

    people_json_array = JSON.dump ({
      people: people_json_array
    })

    File.write("people.json", people_json_array)
  end

  def rental_to_json
    rentals_json = []
    @rentals.each do |r|
      rentals_json.push(r.to_json)
    end

    rentals_json = JSON.dump ({
      rentals: rentals_json
    })

    File.write("rentals.json", rentals_json)
  end

  def from_books_json(books)
    preserved_books = JSON.load books

    preserved_books['books'].each do |obj|
      file = JSON.load(obj)
      @books << Book.new(file['title'], file['author'])
    end
  end


  def from_people_json(people)
    preserved_people = JSON.load people

    preserved_people['people'].each do |obj|
      file = JSON.load(obj)
      if file['classname'] == 'Student'
        @people << Student.new(file['age'], file['name'], file['parent_permission'])
      else 
        @people << Teacher.new(file['age'], file['specialization'], file['name'])
      end
    end
  end

  def from_rentals_json(rentals)
    preserved_rentals = JSON.load rentals
    preserved_rentals['rentals'].each do |obj|
      puts obj
    end
  end
end
