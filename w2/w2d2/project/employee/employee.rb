class Employee
  attr_reader :name, :title, :salary, :boss

  def initialize(name, title, salary, boss)
    @name = name
    @title = title
    @salary = salary
    @boss = boss
  end

  def bonus(multiplier)
    @salary * multiplier
  end
end

class Manager < Employee
  attr_reader :children

  def initialize(name, title, salary, boss, children = [])
    super(name, title, salary, boss)
    @children = children
  end

  def bonus(multiplier)
    total_salary * multiplier
  end

  def total_salary
    queue = children.dup
    total = 0

    until queue.empty?
      current = queue.shift
      total += current.salary

      queue.concat(current.children) if current.is_a?(Manager)
    end

    total
  end

  def add_child(child)
    @children << child
  end
end

if __FILE__ == $PROGRAM_NAME
  ned = Manager.new('Ned', 'Founder', 1_000_000, nil)
  darren = Manager.new('Darren', 'TA Manager', 78_000, ned)
  shawna = Employee.new('Shawna', 'TA', 12_000, darren)
  david = Employee.new('David', 'TA', 10_000, darren)

  ned.add_child(darren)
  darren.add_child(shawna)
  darren.add_child(david)

  p ned.bonus(5) == 500_000
  p ned.bonus(5)

  p darren.bonus(4) == 88_000
  p david.bonus(3) == 30_000
end
