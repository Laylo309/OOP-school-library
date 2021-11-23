require 'json'

class Teacher < Person
  def initialize(age, specialization, name = 'Unknown')
    super(age, name)
    @specialization = specialization
  end

  def can_use_services?
    true
  end

  def to_json
    JSON.dump ({
      classname: self.class,
      age: @age,
      name: @name,
      parent_permission: @parent_permission,
      specialization: @specialization,
    })
  end
end
