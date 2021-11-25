require_relative '../library/student'
require_relative '../library/classroom'

describe Student do
  context 'When instantianting Student class' do
    it 'Create student with default value for parent_permission' do
      # Student.initialize(age, name)
      new_student = Student.new(22, 'Carlos')
      expect(new_student.age).to eq 22
      expect(new_student.name).to eq 'Carlos'
      expect(new_student.parent_permission).to eq true
    end
    it 'Create student with all parameters' do
      # Student.initialize(age, name, parent_permission)
      new_student = Student.new(22, 'Carlos', false)
      expect(new_student.age).to eq 22
      expect(new_student.name).to eq 'Carlos'
      expect(new_student.parent_permission).to eq false
    end
  end

  context 'Running play_hooky method' do
    it 'Should return ¯\(ツ)/¯' do
      new_student = Student.new(22, 'Carlos', false)
      expect(new_student.play_hooky).to eq '¯\(ツ)/¯'
    end
  end

  context 'Testing relation between classroom and student' do
    it 'Add a classroom to student should add the student to the classroom class' do
      new_classroom = Classroom.new('Laylo Playground')
      new_student = Student.new(22, 'Carlos', false)
      new_student.classroom=(new_classroom)
      expect(new_student.classroom).to eq new_classroom
      expect(new_classroom.students[0]).to eq new_student
    end
  end

  context 'creating a json state of the student instance' do
    it 'JSON values should be equal to the class iv' do
      stud = Student.new(22, 'Carlos')
      expect(JSON.parse(stud.to_json)['classname']).to eq stud.class.to_s
      expect(JSON.parse(stud.to_json)['age']).to eq stud.age.to_i
      expect(JSON.parse(stud.to_json)['name']).to eq stud.name
      expect(JSON.parse(stud.to_json)['parent_permission']).to eq stud.parent_permission
      expect(JSON.parse(stud.to_json)['classroom']).to eq stud.classroom

    end
  end
end
