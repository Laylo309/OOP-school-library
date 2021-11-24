require_relative './person'
require_relative './book'
require_relative './classroom'
require_relative './rental'
require_relative './student'
require_relative './teacher'
require 'json'

module Storage
  def from_json(books: nil, people: nil, rentals: nil)
    from_books_json(books) if books
    from_people_json(people) if people
    from_rentals_json(rentals) if rentals
  end

  private

  def book_to_json
    book_json_array = []

    @books.each do |book|
      book_json_array.push(book.to_json)
    end

    book_json_array = JSON.dump({
                                  books: book_json_array
                                })

    File.write('books.json', book_json_array)
  end

  def people_to_json
    people_json_array = []
    @people.each do |person|
      people_json_array.push(person.to_json)
    end

    people_json_array = JSON.dump({
                                    people: people_json_array
                                  })

    File.write('people.json', people_json_array)
  end

  def rental_to_json
    rentals_json = []
    @rentals.each do |r|
      rentals_json.push(r.to_json)
    end

    rentals_json = JSON.dump({
                               rentals: rentals_json
                             })

    File.write('rentals.json', rentals_json)
  end

  def from_books_json(books)
    preserved_books = JSON.parse books

    preserved_books['books'].each do |obj|
      file = JSON.parse(obj)
      @books << Book.new(file['title'], file['author']) if file
    end
  end

  def from_people_json(people)
    preserved_people = JSON.parse people

    preserved_people['people'].each do |obj|
      file = JSON.parse(obj)
      instantiate_json_people(file) if file
    end
  end

  def instantiate_json_people(obj)
    @people << if obj['classname'] == 'Student'
                 Student.new(obj['age'], obj['name'], obj['parent_permission'])
               else
                 Teacher.new(obj['age'], obj['specialization'], obj['name'])
               end
  end

  def from_rentals_json(rentals)
    preserved_rentals = JSON.parse rentals

    preserved_rentals['rentals'].each do |obj|
      obj_json = JSON.parse obj
      people_index = lookup_people(obj_json)
      book_index = lookup_book(obj_json)
      puts people_index, book_index
      date = obj_json['date']
      @rentals << Rental.new(date, @people[people_index], @books[book_index])
    end
  end

  def lookup_people(obj)
    obj = JSON.parse obj['person']
    index = nil

    if obj['classname'] == 'Teacher'
      @people.each_with_index do |p, i|
        if obj['classname'] == p.class.to_s && obj['age'] == p.age && obj['name'] == p.name && obj['specialization'] == p.specialization
          index = i
          break
        end
      end
    else
      @people.each_with_index do |p, i|
        if obj['classname'] == p.class.to_s && obj['age'] == p.age && obj['name'] == p.name && obj['parent_permission'] == p.parent_permission
          index = i
          break
        end
      end
    end

    index
  end

  def lookup_book(obj)
    obj = JSON.parse obj['book']
    index = nil
    @books.each_with_index do |b, i|
      if obj['title'] == b.title && obj['author'] == b.author
        index = i
        break
      end
    end
    index
  end
end
