class Employee 
    attr_reader :salary
    def initialize (name, title,  salary, boss = nil)
        @name, @title, @salary, @boss = name, title, salary, boss
        @boss.employees << self unless boss.nil?
    end

    def bonus(multiplier)
        salary * multiplier
    end
end

class Manager < Employee
    attr_reader :employees
    def initialize(name, title,  salary, boss = nil)
        super
        @employees = []
    end

    def bonus(multiplier)
        all_salary = all_subordinates_salaries(self)
        all_salary * multiplier
    end

    def all_subordinates_salaries(employee)
        return 0 unless employee.is_a?(Manager)
        total_salary = 0
        employee.employees.each do |emp|
            total_salary += emp.salary
            total_salary += all_subordinates_salaries(emp)
        end
        total_salary
    end

end


ned = Manager.new('Ned', 'Founder', 1000000)
darren = Manager.new('Darren', 'TA Manager', 78000, ned)
shawna = Employee.new('Shwanna', 'TA', 12000, darren)
david = Employee.new('David', 'TA', 10000, darren)

puts ned.bonus(5) # => 500_000
puts darren.bonus(4) # => 88_000
puts david.bonus(3) # => 30_000