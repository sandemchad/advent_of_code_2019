require_relative "solution_helper"
include SolutionHelper

def fuel_mass(module_size)
  (module_size / 3).floor - 2
end

def module_fuel_req(i)
  mass = fuel_mass(i)
  return 0 if mass <= 0

  mass + module_fuel_req(mass)
end

def solve_a(data = default_data_file(__FILE__))
  data.split("\n").map(&:to_i).inject(0) { |sum, i| sum + fuel_mass(i) }
end

def solve_b(data = default_data_file(__FILE__))
  data.split("\n").map(&:to_i).inject(0) do |sum, i|
    sum + module_fuel_req(i)
  end
end

expect(654, solve_a("1969"), "1969")

puts "\nSolution for Part A: #{solve_a}"

expect(966, solve_b("1969"), "1969")
expect(50346, solve_b("100756"), "100756")

puts "\nSolution for Part B: #{solve_b}"
