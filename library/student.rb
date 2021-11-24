require_relative './person'
require 'json'

#rubocop:disable all
class Student < Person
  attr_reader :classroom

  def initialize(age, name, classroom, parent_permission = true)
    super(age, name, parent_permission)
    @classroom = classroom
  end

  def play_hooky
    '¯\(ツ)/¯'
  end

  def classroom=(classroom)
    @classroom = classroom
    classroom.students.push(self) unless classroom.students.include?(self)
  end

  def to_json
    JSON.dump ({
      classname: self.class,
      age: @age,
      name: @name,
      parent_permission: @parent_permission,
      classroom: @classroom
    })
  end
end