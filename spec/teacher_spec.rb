require_relative '../library/teacher'

describe Teacher do
  context 'When instantianting Teacher class' do
    it 'Create teacher with default value for name' do
      # Teacher.initialize(age, specialization, name = 'Unknown')
      new_teacher = Teacher.new(22, 'Magic teacher')
      expect(new_teacher.age).to eq 22
      expect(new_teacher.name).to eq 'Unknown'
      expect(new_teacher.parent_permission).to eq true
    end
    it 'Create teach with all parameters' do
      # Teacher.initialize(age, specialization, name = 'Unknown')
      new_teacher = Teacher.new(22, 'Dancer', 'Carlos')
      expect(new_teacher.age).to eq 22
      expect(new_teacher.name).to eq 'Carlos'
      expect(new_teacher.specialization).to eq 'Dancer'
      expect(new_teacher.parent_permission).to eq true
    end
  end

  context 'Running can_use_services?' do
    it 'Should always return true' do
      new_teacher = Teacher.new(22, 'Dancer', 'Carlos')
      expect(new_teacher.can_use_services?).to eq true
    end
  end

  context 'creating a json state of the teacher instance' do
    it 'JSON values should be equal to the class iv' do
      tcher = Teacher.new(22, 'Magic teacher')

      expect(JSON.parse(tcher.to_json)['classname']).to eq tcher.class.to_s
      expect(JSON.parse(tcher.to_json)['age']).to eq tcher.age.to_i
      expect(JSON.parse(tcher.to_json)['name']).to eq tcher.name
      expect(JSON.parse(tcher.to_json)['parent_permission']).to eq tcher.parent_permission
      expect(JSON.parse(tcher.to_json)['specialization']).to eq tcher.specialization
    end
  end
end
