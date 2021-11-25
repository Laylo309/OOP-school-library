require_relative '../library/rental'
require_relative '../library/book'
require_relative '../library/student'
require_relative '../library/teacher'

describe Rental do
  context 'When instantianting Rental class' do
    it 'Create rental and check if book and tchr are equal do our constants' do
      # Rental.initialize(date, person, book)
      book = Book.new('Carlos Diary', 'Carlos')
      stud = Student.new(22, 'Carlos')
      tchr = Teacher.new(22, 'Belly Dancer', 'Carlos')

      rental1 = Rental.new('25/11/2021', stud, book)
      expect(rental1.person).to eq stud
      expect(rental1.book).to eq book
      rental2 = Rental.new('25/11/2021', tchr, book)
      expect(rental2.person).to eq tchr
      expect(rental2.book).to eq book
    end
  end

  context 'Testing relation between classroom and student' do
    it 'Add a classroom to student should add the student to the classroom class' do
      book = Book.new('Carlos Diary', 'Carlos')
      stud = Student.new(22, 'Carlos')
      tchr = Teacher.new(22, 'Belly Dancer', 'Carlos')
      rental1 = Rental.new('25/11/2021', stud, book)
      rental2 = Rental.new('25/11/2021', tchr, book)

      expect(stud.rentals[0]).to eq rental1
      expect(book.rentals[0]).to eq rental1
      expect(tchr.rentals[0]).to eq rental2
      expect(book.rentals[1]).to eq rental2
    end
  end

  context 'creating a json state of the rental instance' do
    it 'JSON values should be equal to the class iv' do
      book = Book.new('Carlos Diary', 'Carlos')
      stud = Student.new(22, 'Carlos')
      stud_json = stud.to_json
      book_json = book.to_json
      rental1 = Rental.new('25/11/2021', stud, book)

      expect(JSON.parse(rental1.to_json)['date']).to eq rental1.date
      expect(JSON.parse(rental1.to_json)['person']).to eq stud_json
      expect(JSON.parse(rental1.to_json)['book']).to eq book_json
    end
  end
end
