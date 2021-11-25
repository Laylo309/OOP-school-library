require_relative '../library/classroom'

describe Classroom do
  context 'When testing a Classroom class' do
    it 'Should create a new Classroom when class new method is called' do
      new_classroom = Classroom.new('Psychology')
      expect(new_classroom.label).to eq 'Psychology'
    end
  end

  context 'When testing class methods' do
    it 'Should add a student to Classroom' do
      new_classroom = Classroom.new('Psychology')
      expect(new_classroom.students).to eq []
      new_classroom.add_student(Student.new('18', 'Laylo', true))
      expect(new_classroom.students).to_not be_empty
    end
  end
end
