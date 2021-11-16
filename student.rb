require_relative './person'

class Student < Person
  def initialize(age:, name: 'Unknown', parent_permission: true)
    super(age: age, name: name, parent_permission: parent_permission)
    @classroom = classroom
  end

  def play_hooky
    '¯\\(ツ)/¯'
  end
end

student = Student.new(age: 15, parent_permission: true, classroom: 'hello')

puts student.play_hooky
