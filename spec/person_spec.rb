require_relative '../library/person'

describe Person do
  context 'When testing with Person class' do
    it 'Should return new Person when when class new method is called' do
      new_person = Person.new('55', 'John')
      expect(new_person.name).to eq 'John'
      expect(new_person.age).to eq '55'
      expect(new_person.parent_permission).to eq true
    end
  end

  context 'When testing can_use_service? method in the class' do
    it 'Should return is it true or false that person can use service' do
      new_person = Person.new(55, 'John')
      expect(new_person.can_use_service?).to eq true
      new_person0 = Person.new(15, 'Jack', false)
      expect(new_person0.can_use_service?).to eq false
    end
  end

  context 'When testing validate_name method in the class' do
    it 'Should validate that name is in correct format with capitalized first letter and no more than 10 characters' do
      new_person = Person.new(55, 'john')
      expect(new_person.validate_name).to eq 'John'
      new_person = Person.new(15, 'nelsinofrancisco')
      expect(new_person.validate_name).to eq 'Nelsinofra'
    end
  end
end
