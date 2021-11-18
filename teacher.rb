require_relative './person'

class Teacher < Person
  def initialize(age, name = 'Unknown', parent_permission = true, specialization)
    super(age: age, name: name, parent_permission: parent_permission)
    @specialization = specialization
  end

  def can_use_services?
    true
  end

end