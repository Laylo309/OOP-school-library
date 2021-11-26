require_relative '../library/book'

describe Book do
  context 'When testing a Book class' do
    it 'should create a new Book when class new method is called' do
      new_book = Book.new('test_title', 'test_author')
      expect(new_book.title).to eq 'test_title'
      expect(new_book.author).to eq 'test_author'
    end
  end
end
